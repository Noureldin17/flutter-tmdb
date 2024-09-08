import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../models/movie_model.dart';
import '../repositories/movies_repository.dart';

class GetMoviesUseCase {
  final MoviesRepository moviesRepository;

  GetMoviesUseCase(this.moviesRepository);
  Future<Either<Failure, List<Movie>>> call(int page, String type) async {
    switch (type) {
      case 'Discover':
        return await moviesRepository.getMovies(page);
      case 'Top Rated':
        return await moviesRepository.getTopRatedMovies(page);
      case 'Upcoming':
        return await moviesRepository.getUpcomingMovies(page);
      case 'Arabic':
        return await moviesRepository.getArabicMovies(page);
      default:
        return await moviesRepository.getMovies(page);
    }
  }
}
