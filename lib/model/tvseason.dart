class TvSeason {

  String airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  String postPath;
  int seasonNumber;

  TvSeason.fromMap(Map jsonMap)
      : airDate = jsonMap['air_date'],
        episodeCount = jsonMap['episode_count'],
        id = jsonMap['id'],
        name = jsonMap['name'],
        overview = jsonMap['overview'],
        postPath = jsonMap['poster_path'],
        seasonNumber = jsonMap['season_number'];

}
