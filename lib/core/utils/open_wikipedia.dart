import 'package:url_launcher/url_launcher.dart';

Future<void> openWikipedia({
  String? scientificName,
  String? countryName,
}) async {
  String urlString;
  if (scientificName != null) {
    urlString =
        "https://en.wikipedia.org/wiki/${scientificName.replaceAll(" ", "_")}";
  } else if (countryName != null) {
    urlString =
        "https://en.wikipedia.org/wiki/${countryName.replaceAll(" ", "_")}";
  } else {
    return;
  }
  final url = Uri.parse(urlString);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print("Coudn't launch url: $url");
  }
}
