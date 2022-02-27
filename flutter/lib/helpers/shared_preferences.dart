import 'package:shared_preferences/shared_preferences.dart' as pref;
import 'package:assistant/helpers/logger.dart';

class SharedPreferences {
  static late final pref.SharedPreferences prefs;

  static Future init() async {
    prefs = await pref.SharedPreferences.getInstance();
    Logger.i("SharedPreferences initialize");
  }
}
