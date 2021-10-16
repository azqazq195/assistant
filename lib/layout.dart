import 'package:flutter/material.dart';
import 'package:assistant/helpers/responsiveness.dart';
import 'package:assistant/widgets/large_screen.dart';
import 'package:assistant/widgets/side_menu.dart';
import 'package:assistant/widgets/small_screen.dart';
import 'package:assistant/widgets/top_nav.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assistant/api/client/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SiteLayout extends StatefulWidget {
  const SiteLayout({Key? key}) : super(key: key);

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final client = RestClient(Dio());
  late Release _latestRelease;

  Future<String> getCurrentVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  Future<String> getLatestVersion() async {
    final release = await client.getReleaseLatest();
    setState(() {
      _latestRelease = release;
    });
    return release.tagName.replaceAll("v", "");
  }

  Future<void> _checkVersion() async {
    final currentVersion = await getCurrentVersion();
    final latestVersion = await getLatestVersion();
    if (currentVersion != latestVersion) {
      _showUpdateAlert(context, _latestRelease);
    }
  }

  Future<void> _checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (isFirstRun) {
      prefs.setBool('isFirstRun', false);
      print("first run");
    } else {
      print("second run");
    }
  }

  Future<void> _openDownloadWebUrl(String version) async {
    final url = _latestRelease.assets[0]["browser_download_url"];
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

  @override
  initState() {
    _checkVersion();
    _checkFirstRun();
    super.initState();
  }

  void _showUpdateAlert(BuildContext context, Release release) {
    final DateTime now = DateTime.parse(release.createdAt);
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    final String formatted = formatter.format(now);
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${release.tagName} 업데이트 알림"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(formatted),
                const Text(""),
                Text(release.body),
              ],
            ),
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
                _openDownloadWebUrl(_latestRelease.tagName);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(child: SideMenu()),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
