import 'package:assistant/api/client/git_rest_client.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';
import 'package:url_launcher/url_launcher.dart';

class Updater {
  Future<String> getCurrentVersion() async {
    return await rootBundle.loadString('pubspec.yaml').then((value) {
      var yaml = loadYaml(value);
      return yaml['msix_config']['msix_version'];
    });
  }

  Future<String> getLatestVersion() async {
    final release = await GitRestClient(Dio()).getReleaseLatest();
    return release.tagName.replaceAll("v", "");
  }

  Future<void> checkVersion(BuildContext context) async {
    final currentVersion = await getCurrentVersion();
    final latestVersion = await getLatestVersion();
    if (currentVersion != latestVersion) {
      _showNewVersion(context);
    }
    print(currentVersion);
    print(latestVersion);
  }

  Future<void> _openDownloadWebUrl() async {
    final release = await GitRestClient(Dio()).getReleaseLatest();
    final url = release.assets[0]["browser_download_url"];
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

  void _showNewVersion(BuildContext context) {
    List<Widget> _releaseList = [];
    _releaseList.add(
      ListBody(
        children: const [
          Text(
            "2021-02-12",
            style: TextStyle(
              color: Colors.orangeAccent,
            ),
          ),
          Text(""),
          Text("업데이트 내용"),
        ],
      ),
    );

    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "새로운 버전",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(children: _releaseList),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('개발자의 노력을 무시하기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('최신 버전 다운로드'),
              onPressed: () {
                Navigator.of(context).pop();
                _openDownloadWebUrl();
              },
            ),
          ],
        );
      },
    );
  }
}
