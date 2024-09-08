import 'package:dartz/dartz.dart';
import 'package:flutter_tmdb/core/error/faliures.dart';
import 'package:flutter_tmdb/movies/domain/models/account_states_model.dart';
import 'package:flutter_tmdb/movies/domain/repositories/movies_repository.dart';

class GetAccountStatesUsecase {
  final MoviesRepository moviesRepository;

  GetAccountStatesUsecase(this.moviesRepository);

  Future<Either<Failure, AccountStates>> call(int movieId) async {
    return await moviesRepository.getAccountStates(movieId);
  }
}
