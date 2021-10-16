import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {

  Future<void> _launchInBrowser(String version) async {
    final url = "https://github.com/azqazq195/assistant/releases/download/$version/Release.zip";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  await _launchInBrowser("v0.3");

}