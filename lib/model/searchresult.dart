import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/util/utils.dart';

class SearchResult {
  String mediaType;
  Map<String, dynamic> data;

  String _getImagePath() {
    switch (mediaType) {
      case "movie":
      case "tv":
        return data['poster_path'] ?? "";
      case "person":
        return data['profile_path'] ?? "";
      default:
        return "";
    }
  }

  String get title {
    switch (mediaType) {
      case "movie":
        return data['title'];
      case "tv":
      case "person":
        return data['name'];
      default:
        return "";
    }
  }

  MediaItem get asMovie => MediaItem(data, MediaType.movie);

  MediaItem get asShow => MediaItem(data, MediaType.show);

  Actor get asActor => Actor.fromJson(data);

  String get subtitle {
    switch (mediaType) {
      case "movie":
        return formatDate(data['release_date']);
      case "tv":
        return formatDate(data['first_air_date']);
      case "person":
        return concatListToString(data['known_for'], 'title');
      default:
        return "";
    }
  }

  String get imageUrl => getMediumPictureUrl(_getImagePath());

  SearchResult.fromJson(Map jsonMap)
      : mediaType = jsonMap['media_type'],
        data = jsonMap;
}
