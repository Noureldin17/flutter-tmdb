import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/authentication/domain/repositories/auth_repository.dart';

class AddToWatchListUsecase {
  final AuthenticationRepo authenticationRepo;

  const AddToWatchListUsecase(this.authenticationRepo);

  Future<Either<Failure, Unit>> call(int movieId, bool value) async {
    return await authenticationRepo.addToWatchList(movieId, value);
  }
}
