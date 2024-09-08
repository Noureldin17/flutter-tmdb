class MovieDetails {
  late int runtime;
  late String productionCompany;
  late String originalLanguage;
  late String overview;
  late List<dynamic> pc;
  late int voteCount;
  late double voteAverage;

  MovieDetails.fromJson(Map<String, dynamic> json) {
    runtime = json['runtime'];
    pc = json['production_companies'];
    if (pc.isEmpty) {
      productionCompany = 'unknown';
    } else {
      productionCompany = json['production_companies'][0]['name'];
    }
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'];
    overview = json['overview'];
    originalLanguage = json['original_language'];
  }
}
