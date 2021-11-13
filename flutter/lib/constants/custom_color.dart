import 'dart:ui';

import 'package:assistant/constants/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomColor {
  static Color primary = primaryColor;
  static Color warning = warningColor;

  static Color fontColor = fontColorLight;
  static Color canvas = canvasLight;
  static Color background = backgroundLight;

  static getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? theme = prefs.get('theme') ?? "null";
    if(theme as String == 'dark') {
      fontColor = fontColorDark;
      canvas = canvasDark;
      background = backgroundDark;
    } else if(theme  == 'light') {
      fontColor = fontColorLight;
      canvas = canvasLight;
      background = backgroundLight;
    }
  }
}