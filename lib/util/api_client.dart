import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/mediaitem.dart';
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
    var response = await (await _http.getUrl(uri)).close();
    var transformedResponse = await response.transform(UTF8.decoder).join();
    return JSON.decode(transformedResponse);
  }

  Future<List<MediaItem>> fetchMovies(
      {int page: 1, String category: "popular"}) async {
    var url = new Uri.https(baseUrl, '3/movie/$category', {
      'api_key': API_KEY,
      'page': page.toString()
    });

    return _getJson(url)
        .then((json) => json['results'])
        .then((data) =>
        data.map((item) => new MediaItem(item, MediaType.movie)).toList());
  }

  Future<List<MediaItem>> getSimilarMovies(int mediaId, {String type: "movie"}) async {
    var url = new Uri.https(baseUrl, '3/$type/$mediaId/similar', {
      'api_key': API_KEY,
    });

    return _getJson(url)
        .then((json) => json['results'])
        .then((data) =>
        data.map((item) => new MediaItem(item, MediaType.movie)).toList());
  }

  Future<List<MediaItem>> getMoviesForActor(int actorId) async {
    var url = new Uri.https(
        baseUrl, '3/discover/movie',
        {
          'api_key': API_KEY,
          'with_cast': actorId.toString(),
          'sort_by': 'popularity.desc'
        });

    return _getJson(url)
        .then((json) => json['results'])
        .then((data) =>
        data.map((item) => new MediaItem(item, MediaType.movie)).toList());
  }

  Future<List<Actor>> getMediaCredits(int mediaId, {String type: "movie"}) async {
    var url = new Uri.https(baseUrl, '3/$type/$mediaId/credits', {
      'api_key': API_KEY
    });

    return _getJson(url)
        .then((json) =>
        json['cast'].map((item) => new Actor.fromJson(item)).toList());
  }

  Future<dynamic> getMediaDetails(int mediaId, {String type: "movie"}) async {
    var url = new Uri.https(baseUrl, '3/$type/$mediaId', {
      'api_key': API_KEY
    });

    return _getJson(url);
  }

  Future<List<MediaItem>> getSearchResults(String query) {
    var url = new Uri.https(baseUrl, '3/search/movie', {
      'api_key': API_KEY,
      'query': query
    });

    return _getJson(url)
        .then((json) =>
        json['results']
            .map((item) => new MediaItem(item, MediaType.movie))
            .toList());
  }

  Future<List<MediaItem>> fetchShows(
      {int page: 1, String category: "popular"}) async {
    var url = new Uri.https(baseUrl, '3/tv/$category', {
      'api_key': API_KEY,
      'page': page.toString()
    });

    return _getJson(url)
        .then((json) => json['results'])
        .then((data) =>
        data.map((item) => new MediaItem(item, MediaType.show)).toList());
  }
}