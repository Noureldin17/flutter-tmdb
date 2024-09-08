part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMoviesEvent extends SearchEvent {
  final String query;

  const SearchMoviesEvent(this.query);
}
