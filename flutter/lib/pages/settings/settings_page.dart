import 'package:assistant/helpers/logger.dart';
import 'package:assistant/helpers/shared_preferences.dart';
import 'package:assistant/helpers/toast_message.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              Logger.i('${SharedPreferences.prefs.getString('theme')} => dark');
              SharedPreferences.prefs.setString('theme', 'dark');
              FlutterToast(context, "재실행 시 적용됩니다.");
            },
            child: const Text("다크 모드")),
        TextButton(
            onPressed: () {
              Logger.i(
                  '${SharedPreferences.prefs.getString('theme')} => light');
              SharedPreferences.prefs.setString('theme', 'light');
              FlutterToast(context, "재실행 시 적용됩니다.");
            },
            child: const Text("라이트 모드")),
        TextButton(
          onPressed: () {
            SharedPreferences.prefs.setBool('auto_login', false);
          },
          child: const Text("로그아웃"),
        )
      ],
    );
  }
}
