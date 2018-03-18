import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final dollarFormat = new NumberFormat("#,##0.00", "en_US");
final sourceFormat = new DateFormat('yyyy-MM-dd');
final dateFormat = new DateFormat.yMMMMd("en_US");

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