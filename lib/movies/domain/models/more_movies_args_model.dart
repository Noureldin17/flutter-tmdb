import 'package:flutter_tmdb/movies/domain/models/movie_model.dart';

class MoreMoviesArgs {
  final String moviesType;
  final List<Movie> movieList;

  MoreMoviesArgs(this.moviesType, this.movieList);
}
