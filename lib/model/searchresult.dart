import 'package:movies_flutter/util/utils.dart';

class SearchResult {

  String mediaType;
  Map<String, dynamic> data;

  String _getImagePath() {
    switch (mediaType) {
      case "movie":
      case "tv":
        return data['poster_path'];
      case "person":
        return data['profile_path'];
      default:
        return "";
    }
  }

  String get title {
    switch (mediaType) {
      case "movie":
      case "tv":
        return data['title'];
      case "person":
        return data['name'];
      default:
        return "";
    }
  }

  String get subtitle {
    switch (mediaType) {
      case "movie":
        return formatDate(data['release_date']);
      case "tv":
        return formatDate(data['first_air_date']);
      case "person":
        return data['name'];
      default:
        return "";
    }
  }

  String get imageUrl => getMediumPictureUrl(_getImagePath());

  SearchResult.fromJson(Map jsonMap)
      : mediaType = jsonMap['media_type'],
        data = jsonMap;

}