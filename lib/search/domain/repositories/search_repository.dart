import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Movie>>> searchMovies(String query, int page);
}
