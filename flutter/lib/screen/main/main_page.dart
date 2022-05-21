import 'package:assistant/components/my_alert_dialog.dart';
import 'package:assistant/screen/code/code_page.dart';
import 'package:assistant/screen/settings/settings_page.dart';
import 'package:assistant/utils/logger.dart';
import 'package:assistant/utils/shared_preferences.dart';
import 'package:assistant/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedDestination = 1;
  static const int _settingsIndex = 50;
  static const int _bugReportIndex = 60;
  static const int _sourceCodeIndex = 70;
  static const int _logoutIndex = 100;
  Color drawerColor = const Color(0xFFFFFBFE);
  Color selectedColor = const Color(0xFFE8DEF8);
  Color textColor = const Color(0xFF1D192B);

  Widget listTile(int index, Icon icon, String name) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListTile(
        leading: icon,
        title: Text(
          name,
          style: TextStyle(
            color: textColor,
          ),
        ),
        selected: _selectedDestination == index,
        onTap: () async => selectDestination(index),
        selectedTileColor: selectedColor,
        iconColor: textColor,
        selectedColor: textColor,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    Widget content() {
      switch (_selectedDestination) {
        case 1:
          return const CodePage();
        case _settingsIndex:
          return const SettingsPage();
        default:
          return const Text("에러");
      }
    }

    Widget drawNav() {
      return Drawer(
        backgroundColor: drawerColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Assistant',
                style: textTheme.headline6,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Main',
              ),
            ),
            spacerH,
            listTile(1, const Icon(Icons.code), "Code"),
            spacerH,
            const Divider(
              height: 1,
              thickness: 1,
            ),
            spacerH,
            listTile(_settingsIndex, const Icon(Icons.settings), "설정"),
            spacerH,
            listTile(_bugReportIndex, const Icon(Icons.bug_report), "버그 제보"),
            spacerH,
            listTile(
                _sourceCodeIndex, const Icon(Icons.source_outlined), "소스 코드"),
            spacerH,
            listTile(_logoutIndex, const Icon(Icons.logout_outlined), "로그아웃"),
          ],
        ),
      );
    }

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          drawNav(),
          Expanded(
            child: content(),
          ),
        ],
      ),
    );
  }

  void selectDestination(int index) async {
    if (index == _logoutIndex) {
      MyAlertDialog(
        context: context,
        title: "로그아웃",
        content: const Text("로그아웃 하시겠습니까?"),
        actionText: "로그아웃",
        actionFunction: () {
          SharedPreferences.prefs.setString(Preferences.email.name, '');
          SharedPreferences.prefs.setString(Preferences.password.name, '');
          SharedPreferences.prefs.setBool(Preferences.autoLogin.name, false);
          Navigator.pushNamed(context, '/signin');
        },
      ).show();
    } else if (index == _sourceCodeIndex) {
      await sourceCode();
    } else if (index == _bugReportIndex) {
      await bugReport();
    } else {
      setState(() {
        _selectedDestination = index;
      });
    }
  }

  sourceCode() async {
    Uri uri = Uri.parse("https://github.com/azqazq195/assistant");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Could not launch '${uri.toString()}'";
    }
  }

  bugReport() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri uri = Uri(
      scheme: 'mailto',
      path: 'azqazq195@gmail.com',
      query: encodeQueryParameters(
        <String, String>{
          'subject': 'Assistant Bug Report',
          'body': '''
------\n\n
내용입력\n\n
------\n\n
${await Logger.logTxt.readAsString()}
'''
        },
      ),
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Could not launch '${uri.toString()}'";
    }
  }
}
