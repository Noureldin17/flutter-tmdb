import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/api/tmdb_api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../../movies/domain/models/movie_model.dart';

abstract class SearchRemoteDatasource {
  Future<List<Movie>> searchMovies(String query, int page);
}

class SearchRemoteDatasourceImpl extends SearchRemoteDatasource {
  final http.Client client;

  SearchRemoteDatasourceImpl(this.client);

  @override
  Future<List<Movie>> searchMovies(String query, int page) async {
    final response = await client.get(
        Uri.parse(
          "${TMDBApiConstants.BASE_URL}search/movie?page=$page&query=$query&api_key=${TMDBApiConstants.API_KEY}",
        ),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List decodedJson = jsonDecode(response.body)["results"];
      final movieList =
          decodedJson.map((movie) => Movie.fromJson(movie)).toList();
      return movieList;
    } else if (response.statusCode == 404) {
      throw EmptyResultException();
    } else {
      throw ServerException();
    }
  }
}
