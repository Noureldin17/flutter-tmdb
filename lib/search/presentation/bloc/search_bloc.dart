// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/faliures.dart';
import '../../../movies/domain/models/movie_model.dart';
import '../../domain/usecases/search_movies_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUsecase searchMoviesUsecase;
  SearchBloc({required this.searchMoviesUsecase}) : super(SearchInitial()) {
    on<SearchEvent>(transformer: sequential(), (event, emit) async {
      if (event is SearchMoviesEvent) {
        emit(SearchMoviesLoading());
        final response = await searchMoviesUsecase.call(event.query, 1);
        response.fold((l) => emit(SearchMoviesError(_mapErrorToMessage(l))),
            (r) => emit(SearchMoviesSuccess(r)));
      }
    });
  }

  String _mapErrorToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "An error has occured with the server";
      case NetworkFailure:
        return "Connection Error";
      case EmptyResultFailure:
        return "There are no results available";
      default:
        return "An error has occured ";
    }
  }
}
