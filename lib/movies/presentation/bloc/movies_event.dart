part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends MoviesEvent {
  final String type;
  final int page;
  const GetMoviesEvent(this.type, this.page);
}

class GetTopRatedMoviesEvent extends MoviesEvent {
  final String type;
  final int page;

  const GetTopRatedMoviesEvent(this.type, this.page);
}

class GetUpcomingMoviesEvent extends MoviesEvent {
  final String type;
  final int page;

  const GetUpcomingMoviesEvent(this.type, this.page);
}

class GetArabicMoviesEvent extends MoviesEvent {
  final String type;
  final int page;

  const GetArabicMoviesEvent(this.type, this.page);
}

class GetTrailerEvent extends MoviesEvent {
  final int movieId;

  const GetTrailerEvent(this.movieId);
}

class GetCreditsEvent extends MoviesEvent {
  final int movieId;

  const GetCreditsEvent(this.movieId);
}

class GetDetailsEvent extends MoviesEvent {
  final int movieId;

  const GetDetailsEvent(this.movieId);
}

class GetAccountStatesEvent extends MoviesEvent {
  final int movieId;

  const GetAccountStatesEvent(this.movieId);
}

class GetRecommendationsEvent extends MoviesEvent {
  final int movieId;

  const GetRecommendationsEvent(this.movieId);
}

class GetMoreMoviesEvent extends MoviesEvent {
  final String type;
  final int page;

  const GetMoreMoviesEvent(this.type, this.page);
}
