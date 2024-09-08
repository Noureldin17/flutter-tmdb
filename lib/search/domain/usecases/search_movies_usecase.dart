import 'package:dartz/dartz.dart';

import '../../../core/error/faliures.dart';
import '../../../movies/domain/models/movie_model.dart';
import '../repositories/search_repository.dart';

class SearchMoviesUsecase {
  final SearchRepository searchRepository;

  SearchMoviesUsecase(this.searchRepository);

  Future<Either<Failure, List<Movie>>> call(String query, int page) async {
    return await searchRepository.searchMovies(query, page);
  }
}
