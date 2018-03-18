class Movie {

  int id;
  double voteAverage;
  String title;
  String posterPath;
  String backdropPath;
  String overview;
  String releaseDate;
  List<int> genreIds;

  static final String imageUrl = "https://image.tmdb.org/t/p/w500/";

  String getBackDropUrl() => imageUrl + backdropPath;

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