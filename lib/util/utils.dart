import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final dollarFormat = new NumberFormat("#,##0.00", "en_US");
final sourceFormat = new DateFormat('yyyy-MM-dd');
final dateFormat = new DateFormat.yMMMMd("en_US");
Map<int, String> genreMap = {
  28: 'Action',
  12: 'Adventure',
  16: 'Animation',
  35: 'Comedy',
  80: 'Crime',
  99: 'Documentary',
  18: 'Drama',
  10751: 'Family',
  14: 'Fantasy',
  36: 'History',
  27: 'Horror',
  10402: 'Music',
  9648: 'Mystery',
  10749: 'Romance',
  878: 'Science Fiction',
  10770: 'TV Movie',
  53: 'Thriller',
  10752: 'War',
  37: 'Western'
};

List<String> getGenresForIds(List<int> genreIds) =>
    genreIds.map((id) => genreMap[id]).toList();

String getGenreString(List<int> genreIds) {
  StringBuffer buffer = new StringBuffer();
  buffer.writeAll(getGenresForIds(genreIds), ", ");
  return buffer.toString();
}


String formatNumberToDollars(int amount) => '\$${dollarFormat.format(amount)}';

String formatDate(String date) {
  try {
    return dateFormat.format(sourceFormat.parse(date));
  } catch (Exception) {
    return "";
  }
}

String formatRuntime(int runtime) {
  int hours = runtime ~/ 60;
  int minutes = runtime % 60;

  return '$hours\h $minutes\m';
}

launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}

String getImdbUrl(String imdbId) => 'http://www.imdb.com/title/$imdbId';