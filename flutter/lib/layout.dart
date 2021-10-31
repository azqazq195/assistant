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
import 'package:flutter/services.dart' show rootBundle;
import 'package:assistant/constants/config.dart' as config;

class SiteLayout extends StatefulWidget {
  const SiteLayout({Key? key}) : super(key: key);

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final client = RestClient(Dio());
  late Release _latestRelease;
  late List<Release> _releaseList;
  var currentVersion = "";

  Future<String> getCurrentVersion() async {
    return await rootBundle.loadString('assets/config/version.txt');
  }

  Future<String> getLatestVersion() async {
    final release = await client.getReleaseLatest();
    setState(() {
      _latestRelease = release;
    });
    return release.tagName.replaceAll("v", "");
  }

  Future<void> getReleaseList() async {
    final release = await client.getReleaseList();
    setState(() {
      _releaseList = release;
    });
  }

  Future<void> _checkVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentVersion = await getCurrentVersion();
    final latestVersion = await getLatestVersion();
    if (currentVersion != latestVersion) {
      _showUpdateAlert(context, _latestRelease);
      prefs.setBool('canUpdate', true);
    } else {
      bool canUpdate = prefs.getBool('canUpdate') ?? false;
      if (canUpdate) {
        await getReleaseList();
        _showUpdatedAlert(context, _releaseList);
        prefs.setBool('canUpdate', false);
      }
    }
    setState(() {
      this.currentVersion = currentVersion;
      config.version = currentVersion;
    });
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
    super.initState();
  }

  void _showUpdatedAlert(BuildContext context, List<Release> releaseList) {
    List<Widget> _releaseList = [];

    for (Release release in releaseList) {
      final DateTime now = DateTime.parse(release.createdAt);
      final DateFormat formatter = DateFormat('MM월 dd일, yyyy');
      final String formatted = formatter.format(now);

      _releaseList.add(ListBody(
        children: [
          Text(
            formatted,
            style: const TextStyle(
              color: Colors.orangeAccent,
            ),
          ),
          const Text(""),
          Text(release.body),
          if (release != releaseList.last) ...[
            const Text(""),
          ]
        ],
      ));
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "업데이트 내역",
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
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                Navigator.of(context).pop();
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
      appBar: topNavigationBar(context, scaffoldKey, "v$currentVersion"),
      drawer: const Drawer(child: SideMenu()),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
