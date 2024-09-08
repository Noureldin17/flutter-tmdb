import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../repositories/auth_repository.dart';

class CheckOnBoardUseCase {
  final AuthenticationRepo authenticationRepo;

  CheckOnBoardUseCase(this.authenticationRepo);

  Future<Either<Failure, LoginStates>> call() async {
    return await authenticationRepo.checkLoginStatesUser();
  }
}
