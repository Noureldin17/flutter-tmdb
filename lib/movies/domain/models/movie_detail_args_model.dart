// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:flutter_tmdb/movies/domain/models/movie_model.dart';

class MovieDetailArgs {
  final String tag;
  final Movie movie;
  // final CacheManager cacheManager;
  MovieDetailArgs(
    this.tag,
    this.movie,
    // this.cacheManager,
  );
}
