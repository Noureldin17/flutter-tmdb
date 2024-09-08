import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:movies_app/features/movies/domain/models/login_states_model.dart';

class CheckOnBoardUseCase {
  final AuthenticationRepo authenticationRepo;

  CheckOnBoardUseCase(this.authenticationRepo);

  Future<Either<Failure, LoginStates>> call() async {
    return await authenticationRepo.checkLoginStatesUser();
  }
}
