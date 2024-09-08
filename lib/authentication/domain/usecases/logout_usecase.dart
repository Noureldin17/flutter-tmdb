import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthenticationRepo authenticationRepo;

  LogoutUseCase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call() async {
    return await authenticationRepo.logoutUser();
  }
}
