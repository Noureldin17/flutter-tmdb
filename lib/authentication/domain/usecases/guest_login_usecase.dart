import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../repositories/auth_repository.dart';

class GuestLoginUseCase {
  final AuthenticationRepo authenticationRepo;

  GuestLoginUseCase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call() async {
    return await authenticationRepo.guestLoginUser();
  }
}
