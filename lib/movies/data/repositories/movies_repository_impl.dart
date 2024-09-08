import 'package:dartz/dartz.dart';
import '../../../core/api/tmdb_api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/faliures.dart';
import '../../../core/network/network_info.dart';
import '../../domain/models/account_states_model.dart';
import '../../domain/models/movie_credits_model.dart';
import '../../domain/models/movie_model.dart';
import '../../domain/models/movie_videos_model.dart';
import '../../domain/models/movies_details_model.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/movies_local_datasource.dart';
import '../datasources/movies_remote_datasource.dart';

class MoviesRep implements MoviesRepository {
  @override
  Future<Either<Failure, AccountStates>> getAccountStates(int movieId) {
    // TODO: implement getAccountStates
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getArabicMovies(int page) {
    // TODO: implement getArabicMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Member>>> getMovieCredits(int movieId) {
    // TODO: implement getMovieCredits
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(int movieId) {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int movieId) {
    // TODO: implement getMovieRecommendations
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MovieVideo>>> getMovieTrailer(int movieId) {
    // TODO: implement getMovieTrailer
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovies(int page) {
    // TODO: implement getMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int page) {
    // TODO: implement getTopRatedMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies(int page) {
    // TODO: implement getUpcomingMovies
    throw UnimplementedError();
  }
}

class MoviesRepoImpl implements MoviesRepository {
  final MoviesRemoteDatasource remoteDatasource;
  final MoviesLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  MoviesRepoImpl(this.remoteDatasource, this.localDatasource, this.networkInfo);

  @override
  Future<Either<Failure, List<Member>>> getMovieCredits(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getMovieCredits(movieId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on EmptyResultException {
        return Left(EmptyResultFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieVideo>>> getMovieTrailer(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getMovieTrailer(movieId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on EmptyResultException {
        return Left(EmptyResultFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovies(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getMovies(
            page, TMDBApiConstants.DISCOVER_MOVIES_ENDPOINT);
        // localDatasource.cacheMovies(response, "Discover");
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final response = await localDatasource.getCachedMovies("Discover");
        return Right(response);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getMovies(
            page, TMDBApiConstants.TOPRATED_MOVIES_ENDPOINT);
        // localDatasource.cacheMovies(response, "TopRated");
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final response = await localDatasource.getCachedMovies("TopRated");
        return Right(response);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getMovies(
            page, TMDBApiConstants.UPCOMING_MOVIES_ENDPOINT);
        // localDatasource.cacheMovies(response, "UpComing");
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final response = await localDatasource.getCachedMovies("UpComing");
        return Right(response);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getArabicMovies(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getMovies(
            page, TMDBApiConstants.ARABIC_MOVIES_ENDPOINT);
        // localDatasource.cacheMovies(response, "UpComing");
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final response = await localDatasource.getCachedMovies("Arabic");
        return Right(response);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getMovieDetails(movieId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(
      int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDatasource.getMovieRecommendations(movieId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on EmptyResultException {
        return Left(EmptyResultFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AccountStates>> getAccountStates(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final sessionId = await localDatasource.getSessionId();
        final response = await remoteDatasource.getAccountStates(
            movieId, sessionId["value"], sessionId["key"]);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      } on EmptyResultException {
        return Left(EmptyResultFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
