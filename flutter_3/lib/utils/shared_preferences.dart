import 'package:shared_preferences/shared_preferences.dart' as pref;
import 'package:assistant/utils/logger.dart';

class SharedPreferences {
  static late final pref.SharedPreferences prefs;

  static Future init() async {
    prefs = await pref.SharedPreferences.getInstance();
    Logger.i("SharedPreferences initialize");
  }

  static set(Preferences preferences, dynamic value) {}

  static dynamic get(Preferences preferences, dynamic value) {}
}

enum Preferences {
  autoLogin,
  email,
  password,
  accessToken,
  refreshToken,

  welcome,
  currentVersion,

  svnUsername,
  svnPassword,
  svnPath,
  svnUrl,

  mysqlUsername,
  mysqlPassword,
  mysqlPath,

  svnPersistencePath,
  localPersistencePath,

  author,

  indicator,
  displayMode,
  themeMode,
  colorIndex,
}
