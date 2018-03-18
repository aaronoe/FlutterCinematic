import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/movie.dart';
import 'package:movies_flutter/util/constants.dart';

class ApiClient {

  static final _client = new ApiClient._internal();
  final _http = new HttpClient();

  ApiClient._internal();

  final String baseUrl = 'api.themoviedb.org';

  static ApiClient get() {
    return _client;
  }

  Future<dynamic> _getJson(Uri uri) async {
    return _http.getUrl(uri)
        .then((request) => request.close())
        .then((response) => response.transform(UTF8.decoder).join())
        .then((responseBody) => JSON.decode(responseBody));
  }

  Future<List<Movie>> pollMovies(
      {int page: 1, String category: "popular"}) async {
    var url = new Uri.https(baseUrl, '3/movie/$category', {
      'api_key': API_KEY,
      'page': page.toString()
    });

    return _getJson(url)
        .then((json) => json['results'])
        .then((data) => data.map((item) => new Movie.fromJson(item)).toList());
  }

  Future<List<Movie>> getSimilarMovies(int movieId) async {
    var url = new Uri.https(baseUrl, '3/movie/$movieId/similar', {
      'api_key': API_KEY,
    });

    return _getJson(url)
        .then((json) => json['results'])
        .then((data) => data.map((item) => new Movie.fromJson(item)).toList());
  }

  Future<List<Movie>> getMoviesForActor(int actorId) async {
    var url = new Uri.https(baseUrl, '3/person/$actorId/movie_credits', {
      'api_key': API_KEY,
    });

    return _getJson(url)
        .then((json) => json['cast'])
        .then((data) => data.map((item) => new Movie.fromJson(item)).toList());
  }

  Future<List<Actor>> getMovieCredits(int movieId) async {
    var url = new Uri.https(baseUrl, '3/movie/$movieId/credits', {
      'api_key': API_KEY
    });

    return _getJson(url)
        .then((json) =>
        json['cast'].map((item) => new Actor.fromJson(item)).toList());
  }

  Future<dynamic> getMovieDetails(int movieId) async {
    var url = new Uri.https(baseUrl, '3/movie/$movieId', {
      'api_key': API_KEY
    });

    return _getJson(url);
  }

}