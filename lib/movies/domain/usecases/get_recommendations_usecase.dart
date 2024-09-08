import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../models/movie_model.dart';
import '../repositories/movies_repository.dart';

class GetRecommendationsUseCase {
  final MoviesRepository moviesRepository;

  GetRecommendationsUseCase(this.moviesRepository);

  Future<Either<Failure, List<Movie>>> call(int movieId) async {
    return await moviesRepository.getMovieRecommendations(movieId);
  }
}
