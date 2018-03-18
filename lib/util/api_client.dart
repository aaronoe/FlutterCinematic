import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/movie.dart';

class ApiClient {

  static final _client = new ApiClient._internal();
  final _http = new HttpClient();

  ApiClient._internal();

  final _key = "";
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
      'api_key': _key,
      'page': page.toString()
    });

    return _getJson(url)
        .then((json) => json['results'])
        .then((data) => data.map((item) => new Movie.fromJson(item)).toList());
  }

  Future<List<CastMember>> getMovieCredits(int movieId) async {
    var url = new Uri.https(baseUrl, '3/movie/$movieId/credits', {
      'api_key': _key
    });

    return _getJson(url)
        .then((json) =>
        json['cast'].map((item) => new CastMember.fromJson(item)).toList());
  }

}