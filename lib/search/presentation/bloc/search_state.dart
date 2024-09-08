part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchMoviesLoading extends SearchState {}

class SearchMoviesSuccess extends SearchState {
  final List<Movie> movieList;

  const SearchMoviesSuccess(this.movieList);
}

class SearchMoviesError extends SearchState {
  final String message;

  const SearchMoviesError(this.message);
}
