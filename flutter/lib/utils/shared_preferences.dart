import 'package:shared_preferences/shared_preferences.dart' as pref;
import 'package:fluent/utils/logger.dart';

class SharedPreferences {
  static late final pref.SharedPreferences prefs;

  static Future init() async {
    prefs = await pref.SharedPreferences.getInstance();
    Logger.i("SharedPreferences initialize");
  }
}

enum Preferences {
  autoLogin,
  welcome,

  svnUsername,
  svnPassword,
  svnPath,
  svnUrl,

  mysqlUsername,
  mysqlPassword,
  mysqlPath,
  persistencePath,

  indicator,
  displayMode,
  themeMode,
  colorIndex,
}
