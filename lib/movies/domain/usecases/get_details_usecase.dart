import 'package:dartz/dartz.dart';
import 'package:flutter_tmdb/core/error/faliures.dart';
import 'package:flutter_tmdb/movies/domain/models/movies_details_model.dart';

import '../repositories/movies_repository.dart';

class GetMovieDetailsUseCase {
  final MoviesRepository moviesRepository;

  GetMovieDetailsUseCase(this.moviesRepository);

  Future<Either<Failure, MovieDetails>> call(int movieId) async {
    return await moviesRepository.getMovieDetails(movieId);
  }
}
