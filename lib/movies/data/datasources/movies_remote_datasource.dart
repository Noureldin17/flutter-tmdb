import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../core/api/tmdb_api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/models/account_states_model.dart';
import '../../domain/models/movie_credits_model.dart';
import '../../domain/models/movie_model.dart';
import '../../domain/models/movie_videos_model.dart';
import '../../domain/models/movies_details_model.dart';

abstract class MoviesRemoteDatasource {
  Future<List<Movie>> getMovies(int page, String endpoint);

  Future<List<MovieVideo>> getMovieTrailer(int movieId);

  Future<List<Member>> getMovieCredits(int movieId);

  Future<MovieDetails> getMovieDetails(int movieId);

  Future<AccountStates> getAccountStates(
      int movieId, String sessionId, String sessionType);

  Future<List<Movie>> getMovieRecommendations(int movieId);
}

class MoviesRemoteImplWithHttp implements MoviesRemoteDatasource {
  final http.Client client;

  MoviesRemoteImplWithHttp(this.client);

  @override
  Future<List<Member>> getMovieCredits(int movieId) async {
    final response = await client.get(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}movie/$movieId/credits?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List decodedJson = json.decode(response.body)["cast"];

      if (decodedJson.isEmpty) {
        throw EmptyResultException();
      } else {
        List<Member> actorList =
            decodedJson.map((json) => Member.fromJson(json)).toList();
        actorList
            .retainWhere((element) => element.knownForDepartment == 'Acting');
        return actorList;
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieVideo>> getMovieTrailer(int movieId) async {
    final response = await client.get(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}movie/$movieId/videos?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List decodedJson = json.decode(response.body)["results"];
      if (decodedJson.isNotEmpty) {
        List<MovieVideo> trailer =
            decodedJson.map((json) => MovieVideo.fromJson(json)).toList();

        trailer.retainWhere((element) => element.type == "Trailer");
        return trailer;
      } else {
        throw EmptyResultException();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Movie>> getMovies(int page, String endpoint) async {
    final response = await client.get(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}${endpoint}api_key=${TMDBApiConstants.API_KEY}&page=$page"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List decodedJson = json.decode(response.body)["results"];
      List<Movie> movieList =
          decodedJson.map((json) => Movie.fromJson(json)).toList();
      return movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    final response = await client.get(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}movie/$movieId?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      MovieDetails movieDetails = MovieDetails.fromJson(decodedJson);
      return movieDetails;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Movie>> getMovieRecommendations(int movieId) async {
    final response = await client.get(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}movie/$movieId/recommendations?api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List decodedJson = json.decode(response.body)['results'];
      if (decodedJson.isEmpty) {
        throw EmptyResultException();
      } else {
        List<Movie> recommendations =
            decodedJson.map((json) => Movie.fromJson(json)).toList();
        return recommendations;
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AccountStates> getAccountStates(
      int movieId, String sessionId, String sessionType) async {
    final response = await client.get(
        Uri.parse(
            "${TMDBApiConstants.BASE_URL}movie/$movieId/account_states?$sessionType=$sessionId&api_key=${TMDBApiConstants.API_KEY}"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      AccountStates accountStates = AccountStates.fromJson(decodedJson);
      return accountStates;
    } else if (response.statusCode == 404) {
      throw EmptyResultException();
    } else {
      throw ServerException();
    }
  }
}
