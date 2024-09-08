import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../models/movie_videos_model.dart';
import '../repositories/movies_repository.dart';

class GetTrailerUseCase {
  final MoviesRepository moviesRepository;

  GetTrailerUseCase(this.moviesRepository);

  Future<Either<Failure, List<MovieVideo>>> call(int movieId) async {
    return await moviesRepository.getMovieTrailer(movieId);
  }
}
