class Movie {
  late int movieId;
  late bool adult;
  late String movieTitle;
  late String backdropPath;
  late String posterPath;
  late String overview;
  late String releaseDate;
  late num voteAverage;
  late List<int> genreIds;

  Movie.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'] ?? '';
    genreIds = json['genre_ids'].cast<int>();
    movieId = json['id'];
    posterPath = json['poster_path'] ?? '';
    try {
      releaseDate = DateTime.parse(json['release_date']).year.toString();
    } catch (_) {
      releaseDate = '????';
    }
    // movieTitle = json['title'];
    overview = json['overview'];
    voteAverage = json['vote_average'];

    movieTitle = json['original_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = movieId;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = movieTitle;
    data['overview'] = overview;

    return data;
  }
}
