import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../repositories/auth_repository.dart';

class AddRatingUsecase {
  final AuthenticationRepo authenticationRepo;

  AddRatingUsecase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call(int movieId, num value) async {
    return await authenticationRepo.addRating(movieId, value);
  }
}
