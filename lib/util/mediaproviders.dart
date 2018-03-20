import 'dart:async';

import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/util/api_client.dart';

abstract class MediaProvider {

  Future<List<MediaItem>> loadMedia({int page: 1});

}

class MovieProvider extends MediaProvider {

  String category;
  MovieProvider(this.category);
  ApiClient _apiClient = ApiClient.get();

  @override
  Future<List<MediaItem>> loadMedia({int page: 1}) {
    return _apiClient.fetchMovies(category: category, page: page);
  }

}

class ShowProvider extends MediaProvider {

  String category;
  ShowProvider(this.category);
  ApiClient _apiClient = ApiClient.get();

  @override
  Future<List<MediaItem>> loadMedia({int page: 1}) {
    return _apiClient.fetchShows(category: category, page: page);
  }

}