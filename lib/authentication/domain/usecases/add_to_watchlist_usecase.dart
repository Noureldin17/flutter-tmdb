import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../repositories/auth_repository.dart';

class AddToWatchListUsecase {
  final AuthenticationRepo authenticationRepo;

  const AddToWatchListUsecase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call(int movieId, bool value) async {
    return await authenticationRepo.addToWatchList(movieId, value);
  }
}
