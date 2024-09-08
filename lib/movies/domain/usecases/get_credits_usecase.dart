import 'package:dartz/dartz.dart';
import 'package:flutter_tmdb/core/error/faliures.dart';
import 'package:flutter_tmdb/movies/domain/models/movie_credits_model.dart';
import 'package:flutter_tmdb/movies/domain/repositories/movies_repository.dart';

class GetCreditsUseCase {
  final MoviesRepository moviesRepository;

  GetCreditsUseCase(this.moviesRepository);

  Future<Either<Failure, List<Member>>> call(int movieId) async {
    return await moviesRepository.getMovieCredits(movieId);
  }
}
