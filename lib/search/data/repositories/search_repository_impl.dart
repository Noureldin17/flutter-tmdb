import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/faliures.dart';
import '../../../core/network/network_info.dart';
import '../../../movies/domain/models/movie_model.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDatasource searchRemoteDatasource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(this.searchRemoteDatasource, this.networkInfo);
  @override
  Future<Either<Failure, List<Movie>>> searchMovies(
      String query, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await searchRemoteDatasource.searchMovies(query, page);
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
