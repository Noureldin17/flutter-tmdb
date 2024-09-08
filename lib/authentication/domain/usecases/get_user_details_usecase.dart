import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../models/tmdb_user_model.dart';
import '../repositories/auth_repository.dart';

class GetUserDetailsUsecase {
  final AuthenticationRepo authenticationRepo;

  GetUserDetailsUsecase(this.authenticationRepo);

  Future<Either<Failure, TMDBUser>> call() async {
    return await authenticationRepo.getUserDetails();
  }
}
