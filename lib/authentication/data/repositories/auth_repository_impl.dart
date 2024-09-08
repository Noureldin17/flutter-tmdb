// ignore_for_file: unnecessary_null_comparison
import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/faliures.dart';
import '../../../core/network/network_info.dart';
import '../../../movies/domain/models/login_states_model.dart';
import '../../../movies/domain/models/movie_model.dart';
import '../../domain/models/request_token_model.dart';
import '../../domain/models/tmdb_user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepoImpl(
      this.remoteDataSource, this.localDataSource, this.networkInfo);

  Future<Either<Failure, RequestTokenModel>> _getRequestToken() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getRequestToken();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on InvalidCredentialsException {
        return Left(InvalidCredentialsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> loginUser(
      Map<String, dynamic> params, bool keepMeSignedIn) async {
    final response = await _getRequestToken();
    final token1 = response.fold((l) => null, (r) => r.requestToken);
    if (await networkInfo.isConnected) {
      try {
        params.putIfAbsent('request_token', () => token1);
        final validateWithLoginToken =
            await remoteDataSource.validateWithLogin(params);
        final sessionId = await remoteDataSource
            .createSession(validateWithLoginToken.toJson());
        if (sessionId != null) {
          localDataSource.saveSessionId(sessionId, 'user', keepMeSignedIn);
          return const Right(unit);
        } else {
          return Left(InvalidCredentialsFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      } on InvalidCredentialsException {
        return Left(InvalidCredentialsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logoutUser() async {
    if (await networkInfo.isConnected) {
      try {
        final id = await localDataSource.getSessionId();
        if (id['key'] == "guest_session_id") {
          localDataSource.deleteSessionId();
          return const Right(unit);
        } else {
          localDataSource.deleteSessionId();
          await remoteDataSource.deleteSession(id['value']);
          return const Right(unit);
        }
      } on InvalidCredentialsException {
        return Left(InvalidCredentialsFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> guestLoginUser() async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await remoteDataSource.createGuestSession();
        if (sessionId != null) {
          localDataSource.saveSessionId(sessionId, 'guest', false);
          return const Right(unit);
        } else {
          return Left(InvalidCredentialsFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      } on InvalidCredentialsException {
        return Left(InvalidCredentialsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, LoginStates>> checkLoginStatesUser() async {
    final isOnboard = await localDataSource.checkOnBoardUser();
    final keepSignedIn = await localDataSource.keepSignedIn();
    return Right(LoginStates(isOnboard, keepSignedIn));
  }

  @override
  Future<Either<Failure, Unit>> onBoardUser() async {
    try {
      await localDataSource.onBoardUser();
      return const Right(unit);
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addToWatchList(int movieId, bool value) async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await localDataSource.getSessionId();
        await remoteDataSource.addToWatchList(
            movieId, value, sessionId['value']);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on UnAuthorizedException {
        return Left(UnAuthorizedFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchList() async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await localDataSource.getSessionId();
        final response =
            await remoteDataSource.getWatchList(sessionId['value']);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on UnAuthorizedException {
        return Left(UnAuthorizedFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addRating(int movieId, num value) async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await localDataSource.getSessionId();
        await remoteDataSource.addRating(
            movieId, value, sessionId['value'], sessionId['key']);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on UnAuthorizedException {
        return Left(UnAuthorizedFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteRating(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await localDataSource.getSessionId();
        await remoteDataSource.deleteRating(
            movieId, sessionId['value'], sessionId['key']);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on UnAuthorizedException {
        return Left(UnAuthorizedFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, TMDBUser>> getUserDetails() async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await localDataSource.getSessionId();
        if (sessionId['key'] == "session_id") {
          final response =
              await remoteDataSource.getUserDetails(sessionId['value']);
          return Right(response);
        } else {
          return Left(UnAuthorizedFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      } on UnAuthorizedException {
        return Left(UnAuthorizedFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
