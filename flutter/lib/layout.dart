import 'package:assistant/api/client/user_rest_client.dart';
import 'package:assistant/helpers/window_size.dart';
import 'package:flutter/material.dart';
import 'package:assistant/helpers/responsiveness.dart';
import 'package:assistant/widgets/large_screen.dart';
import 'package:assistant/widgets/side_menu.dart';
import 'package:assistant/widgets/small_screen.dart';
import 'package:assistant/widgets/top_nav.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assistant/api/client/git_rest_client.dart';
import 'package:dio/dio.dart' hide Response;
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

  final gitClient = GitRestClient(Dio());
  final userClient = UserRestClient(Dio());
  late Release _latestRelease;
  late List<Release> _releaseList;
  var currentVersion = "";

  Future<String> getCurrentVersion() async {
    return await rootBundle.loadString('assets/config/version.txt');
  }

  Future<String> getLatestVersion() async {
    final release = await gitClient.getReleaseLatest();
    setState(() {
      _latestRelease = release;
    });
    return release.tagName.replaceAll("v", "");
  }

  Future<void> getReleaseList() async {
    final release = await gitClient.getReleaseList();
    setState(() {
      _releaseList = release;
    });
  }

  Future<void> checkVersion() async {
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
    // login();
    setWindowSize(1600, 1000);
    checkVersion();
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

  Future<void> login() async {
    _showLoginAlert(context, await userClient.getUser(3));
  }

  void _showLoginAlert(BuildContext context, Response response) {
    User user = User(
      id: response.data[0]['id'] as int,
      name: response.data[0]['name'] as String,
      email: response.data[0]['email'] as String,
      createdDate: DateTime.parse(response.data[0]['createdDate'] as String),
      updatedDate: response.data[0]['updatedDate'] == null
          ? null
          : DateTime.parse(response.data[0]['updatedDate'] as String),
    );

    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(user.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(user.email),
                const Text(""),
                Text(response.result),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
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
      // appBar: topNavigationBar(context, scaffoldKey, "v$currentVersion"),
      drawer: const Drawer(child: SideMenu()),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
