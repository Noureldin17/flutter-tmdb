import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';

class AddRatingUsecase {
  final AuthenticationRepo authenticationRepo;

  AddRatingUsecase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call(int movieId, num value) async {
    return await authenticationRepo.addRating(movieId, value);
  }
}
