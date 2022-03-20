import 'package:dio/dio.dart' hide Response;
import 'package:fluent/api/client/git_rest_client.dart';
import 'package:fluent/utils/logger.dart';
import 'package:fluent/utils/utils.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaml/yaml.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

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

  Future<Release> getLatestRelease() async {
    return await GitRestClient(Dio()).getReleaseLatest();
  }

  Future<List<Release>> getReleaseList() async {
    return await GitRestClient(Dio()).getReleaseList();
  }

  Future<bool> isUpdated() async {
    final prefs = await SharedPreferences.getInstance();
    final bool updated = prefs.getBool('updated') ?? true;
    if (updated) {
      await prefs.setBool('updated', false);
      return true;
    }
    return false;
  }

  Future<void> checkVersion(BuildContext context) async {
    Logger.i('check version');
    final currentVersion = await getCurrentVersion();
    final latestVersion = await getLatestVersion();

    if (currentVersion != latestVersion) {
      Logger.i('this app is old version');
      await _showUpdateSnackbar(context);
      return;
    }

    if (await isUpdated()) {
      Logger.i('this app was updated');
      _showUpdatedAlert(context);
    }
  }

  Future<void> openDownloadWebUrl() async {
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

  Future<Widget> _releaseList() async {
    List<Widget> _releaseList = [];
    List<Release> releaseList = await getReleaseList();

    for (Release release in releaseList) {
      final DateTime createdAt = DateTime.parse(release.createdAt);
      final DateFormat dateFormat = DateFormat('MM월 dd일, yyyy');
      final String date = dateFormat.format(createdAt);

      _releaseList.add(
        ListBody(
          children: [
            Text(
              date,
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
            const Text(""),
            Text(release.body),
            if (release != releaseList.last) ...[
              const Text(""),
            ]
          ],
        ),
      );
    }

    return ListBody(
      children: _releaseList,
    );
  }

  Future<void> _showUpdatedAlert(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: Text(
          "업데이트 내역",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: FutureBuilder<Widget>(
            future: _releaseList(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data;
              } else {
                return const ProgressRing();
              }
            },
          ),
        ),
        actions: [
          FilledButton(
            child: const Text('Update'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showUpdateSnackbar(BuildContext context) async {
    Release release = await getLatestRelease();
    String createdAt = DateFormat("yyyy-MM-dd")
        .format(DateFormat("yyyy-MM-dd").parse(release.createdAt));

    showSnackbar(
      context,
      Snackbar(
        extended: true,
        content: ListBody(
          children: [
            Text(
              createdAt,
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            spacerH,
            MarkdownBody(data: release.body),
          ],
        ),
        action: TextButton(
          child: const Text('Download'),
          onPressed: () async {
            await Updater().openDownloadWebUrl();
          },
        ),
      ),
      duration: const Duration(seconds: 3),
    );
  }
}
