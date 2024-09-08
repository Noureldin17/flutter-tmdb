import 'package:dartz/dartz.dart';
import '../../../core/error/faliures.dart';
import '../repositories/auth_repository.dart';

class DeleteRatingUsecase {
  final AuthenticationRepo authenticationRepo;

  DeleteRatingUsecase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call(int movieId) async {
    return await authenticationRepo.deleteRating(movieId);
  }
}
