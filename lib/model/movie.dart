import 'package:movies_flutter/util/utils.dart';

class Movie {

  int id;
  double voteAverage;
  String title;
  String posterPath;
  String backdropPath;
  String overview;
  String releaseDate;
  List<int> genreIds;

  String getBackDropUrl() => getLargePictureUrl(backdropPath);

  String getPosterUrl() => getMediumPictureUrl(posterPath);

  int getReleaseYear() =>
      DateTime
          .parse(releaseDate)
          .year;

  Movie.fromJson(Map jsonMap)
      :
        id = jsonMap["id"].toInt(),
        voteAverage = jsonMap["vote_average"].toDouble(),
        title = jsonMap["title"],
        posterPath = jsonMap["poster_path"],
        backdropPath = jsonMap["backdrop_path"],
        overview = jsonMap["overview"],
        releaseDate = jsonMap["release_date"],
        genreIds = jsonMap["genre_ids"];

}