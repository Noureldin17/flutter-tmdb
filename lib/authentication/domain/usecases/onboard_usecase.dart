import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../repositories/auth_repository.dart';

class OnBoardUseCase {
  final AuthenticationRepo authenticationRepo;

  OnBoardUseCase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call() async {
    return await authenticationRepo.onBoardUser();
  }
}
