import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../../../movies/domain/models/movie_model.dart';
import '../repositories/auth_repository.dart';

class GetWatchListUsecase {
  final AuthenticationRepo authenticationRepo;

  GetWatchListUsecase(this.authenticationRepo);

  Future<Either<Failure, List<Movie>>> call() async {
    return await authenticationRepo.getWatchList();
  }
}
