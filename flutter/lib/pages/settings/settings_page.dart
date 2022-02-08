import 'package:assistant/helpers/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('theme', 'dark');
              FlutterToast(context, "재실행 시 적용됩니다.");
            },
            child: const Text("다크 모드")),
        TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('theme', 'light');
              FlutterToast(context, "재실행 시 적용됩니다.");
            },
            child: const Text("라이트 모드"))
      ],
    );
  }
}
