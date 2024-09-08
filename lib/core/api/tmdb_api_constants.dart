class TMDBApiConstants {
  TMDBApiConstants._();
  // static const IMAGE_BASE_URL = "https://image.tmdb.org/t/p/original";
  // ignore: constant_identifier_names
  static const IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500";
  // ignore: constant_identifier_names
  static const BASE_URL = "https://api.themoviedb.org/3/";
  // ignore: constant_identifier_names
  static const API_KEY = "ef16bfa151221280ed88c1b436c10876";
  // ignore: constant_identifier_names
  static const DISCOVER_MOVIES_ENDPOINT = "discover/movie?";
  // ignore: constant_identifier_names
  static const UPCOMING_MOVIES_ENDPOINT = "movie/upcoming?";
  // ignore: constant_identifier_names
  static const TOPRATED_MOVIES_ENDPOINT = "movie/top_rated?";
  // ignore: constant_identifier_names
  static const ARABIC_MOVIES_ENDPOINT =
      "discover/movie?include_adult=false&include_video=false&language=en-US&sort_by=popularity.desc&with_origin_country=EG&with_original_language=ar&";
  // static const TRENDING_MOVIES_ENDPOINT = "trending/movie/day";
  // ignore: constant_identifier_names
  static const MOVIE_GENRES = {
    12: "Adventure",
    28: "Action",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western"
  };

  // ignore: constant_identifier_names
  static const MOVIE_LANGUAGES = {
    'ar': 'Arabic',
    'en': 'English',
  };
}
