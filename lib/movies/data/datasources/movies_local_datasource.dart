import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/models/movie_model.dart';

abstract class MoviesLocalDatasource {
  Future<List<Movie>> getCachedMovies(String type);

  Future<Map<dynamic, dynamic>> getSessionId();

  Future<Unit> cacheMovies(List<Movie> movies, String type);
}

class MoviesLocalImpl implements MoviesLocalDatasource {
  final SharedPreferences sharedPreferences;

  MoviesLocalImpl(this.sharedPreferences);

  @override
  Future<Unit> cacheMovies(List<Movie> movies, String type) {
    try {
      List list = getCachedMovies(type) as List<dynamic>;
      List moviesList =
          movies.map<Map<String, dynamic>>((movie) => movie.toJson()).toList();
      list.add(moviesList);
      sharedPreferences.setString("${type}_Cached_Movies", jsonEncode(list));
      return Future.value(unit);
    } catch (e) {
      List moviesList =
          movies.map<Map<String, dynamic>>((movie) => movie.toJson()).toList();
      sharedPreferences.setString(
          "${type}_Cached_Movies", jsonEncode(moviesList));
      return Future.value(unit);
    }
  }

  @override
  Future<List<Movie>> getCachedMovies(String type) {
    final jsonString = sharedPreferences.getString("${type}_Cached_Movies");

    if (jsonString != null) {
      List decodedJson = jsonDecode(jsonString);
      List<Movie> jsonToMovies =
          decodedJson.map<Movie>((movie) => Movie.fromJson(movie)).toList();
      return Future.value(jsonToMovies);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Map<dynamic, dynamic>> getSessionId() async {
    final value = sharedPreferences.getString('session_id');
    if (value != null) {
      return {'key': 'session_id', 'value': value.toString()};
    } else {
      final value = sharedPreferences.getString('guest_session_id');
      return {'key': 'guest_session_id', 'value': value.toString()};
    }
  }
}
