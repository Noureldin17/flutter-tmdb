class TMDBUser {
  late int id;
  late String iso6391;
  late String iso31661;
  late String name;
  late bool includeAdult;
  late String username;
  late String avatar;

  TMDBUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    name = json['name'];
    includeAdult = json['include_adult'];
    username = json['username'];
    avatar = json['avatar']['tmdb']['avatar_path'] ?? '';
  }
}
