import 'dart:convert';
import 'package:dartz/dartz.dart';
// import 'package:http/http.dart';
import '../../../core/api/tmdb_api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../../movies/domain/models/movie_model.dart';
import '../../domain/models/request_token_model.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/tmdb_user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<RequestTokenModel> getRequestToken();
  Future<RequestTokenModel> validateWithLogin(Map<String, dynamic> body);
  Future<String> createSession(Map<String, dynamic> body);
  Future<String> createGuestSession();
  Future<Unit> deleteSession(String sessionId);
  Future<TMDBUser> getUserDetails(String sessionId);
  Future<Unit> addToWatchList(int movieId, bool value, String accountId);
  Future<Unit> addRating(
      int movieId, num value, String accountId, String sessionType);
  Future<Unit> deleteRating(int movieId, String accountId, String sessionType);
  Future<List<Movie>> getWatchList(String accountId);
}

class AuthenticationRemoteImplWithHttp
    implements AuthenticationRemoteDataSource {
  final http.Client client;

  AuthenticationRemoteImplWithHttp(this.client);

  @override
  Future<RequestTokenModel> getRequestToken() async {
    final response = await client.get(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}authentication/token/new?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": 'application/json'});
    if (response.statusCode == 200) {
      return RequestTokenModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RequestTokenModel> validateWithLogin(Map<String, dynamic> body) async {
    final response = await client.post(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}authentication/token/validate_with_login?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": 'application/json'},
        body: json.encode(body));

    if (response.statusCode == 200) {
      return RequestTokenModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw InvalidCredentialsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createSession(Map<String, dynamic> body) async {
    final response = await client.post(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}authentication/session/new?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": 'application/json'},
        body: json.encode(body));
    if (response.statusCode == 200) {
      return json.decode(response.body)['success'] == true
          ? json.decode(response.body)['session_id']
          : null;
    } else if (response.statusCode == 401) {
      throw InvalidCredentialsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createGuestSession() async {
    final response = await client.get(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}authentication/guest_session/new?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": 'application/json'});
    if (response.statusCode == 200) {
      return json.decode(response.body)['success'] == true
          ? json.decode(response.body)['guest_session_id']
          : null;
    } else if (response.statusCode == 401) {
      throw InvalidCredentialsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteSession(String sessionId) async {
    final response = await client.delete(
        Uri.parse(
            '${TMDBApiConstants.BASE_URL}authentication/session?api_key=${TMDBApiConstants.API_KEY}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'session_id': sessionId}));

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 401) {
      throw InvalidCredentialsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addToWatchList(int movieId, bool value, String accountId) async {
    final response = await client.post(
        Uri.parse(
            '${TMDBApiConstants.BASE_URL}account/$accountId/watchlist?api_key=${TMDBApiConstants.API_KEY}&session_id=$accountId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {'media_type': 'movie', "media_id": movieId, "watchlist": value}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Movie>> getWatchList(String accountId) async {
    final response = await client.get(
        Uri.parse(
            '${TMDBApiConstants.BASE_URL}account/$accountId/watchlist/movies?api_key=${TMDBApiConstants.API_KEY}&session_id=$accountId'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List decodedJson = json.decode(response.body)["results"];
      List<Movie> movieList =
          decodedJson.map((json) => Movie.fromJson(json)).toList();
      return movieList;
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addRating(
      int movieId, num value, String accountId, String sessionType) async {
    final response = await client.post(
        Uri.parse(
            '${TMDBApiConstants.BASE_URL}movie/$movieId/rating?api_key=${TMDBApiConstants.API_KEY}&$sessionType=$accountId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'value': value}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteRating(
      int movieId, String accountId, String sessionType) async {
    final response = await client.delete(
      Uri.parse(
          '${TMDBApiConstants.BASE_URL}movie/$movieId/rating?api_key=${TMDBApiConstants.API_KEY}&$sessionType=$accountId'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TMDBUser> getUserDetails(String sessionId) async {
    final response = await client.get(
        Uri.parse(
            '${TMDBApiConstants.BASE_URL}account/$sessionId?api_key=${TMDBApiConstants.API_KEY}&session_id=$sessionId'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final tmdbUser = TMDBUser.fromJson(decodedJson);
      return tmdbUser;
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else {
      throw ServerException();
    }
  }
}
