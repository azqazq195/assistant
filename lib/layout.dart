import 'package:flutter/material.dart';
import 'package:sql_to_mapper/helpers/responsiveness.dart';
import 'package:sql_to_mapper/widgets/large_screen.dart';
import 'package:sql_to_mapper/widgets/side_menu.dart';
import 'package:sql_to_mapper/widgets/small_screen.dart';
import 'package:sql_to_mapper/widgets/top_nav.dart';
import 'package:yaml/yaml.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteLayout extends StatefulWidget {
  const SiteLayout({Key? key}) : super(key: key);

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  var thisVersion = "";
  var lastVersion = "0.0.5";

  Future<String> getVersion() async {
    final configFile = File('pubspec.yaml');
    final yamlString = await configFile.readAsString();
    final dynamic yamlMap = loadYaml(yamlString);
    return yamlMap['version'];
  }

  Future<void> _checkVersion() async {
    final version = await getVersion();
    setState(() {
      thisVersion = version;
      if(thisVersion != lastVersion) {
        _showAlert(context, lastVersion);
      }
    });
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

  @override
  initState()  {
    _checkVersion();
    _checkFirstRun();
    super.initState();
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

  void _showAlert(BuildContext context, String version) {
    final DateTime now = DateTime.parse("1969-07-20 20:18:04Z");
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    final String formatted = formatter.format(now);

    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("업데이트 알림"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('v$version'),
                Text(formatted),
                const Text('Release Note.'),
                const Text('리스트'),
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
              },
            ),
          ],
        );
      },
    );
  }
}
