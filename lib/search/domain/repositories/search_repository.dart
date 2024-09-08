import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../../../movies/domain/models/movie_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Movie>>> searchMovies(String query, int page);
}
