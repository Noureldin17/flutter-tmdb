import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../models/login_request_params.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthenticationRepo authenticationRepo;

  LoginUseCase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call(
      LoginRequestParams loginRequestParams) async {
    return await authenticationRepo.loginUser(
        loginRequestParams.toJson(), loginRequestParams.keepMeSignedIn);
  }
}
