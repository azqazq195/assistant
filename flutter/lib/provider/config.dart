import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

import 'package:fluent/utils/shared_preferences.dart';

class Config extends ChangeNotifier {
  String _mysqlUsername =
      SharedPreferences.prefs.getString(Preferences.mysqlUsername.name) ?? '';
  String get mySqlUsername => _mysqlUsername;
  set mysqlUsername(String mysqlUsername) {
    _mysqlUsername = mysqlUsername;
    SharedPreferences.prefs
        .setString(Preferences.mysqlUsername.name, mysqlUsername);
    notifyListeners();
  }

  String _mysqlPassword =
      SharedPreferences.prefs.getString(Preferences.mysqlPassword.name) ?? '';
  String get mysqlPassword => _mysqlPassword;
  set mysqlPassword(String mysqlPassword) {
    _mysqlPassword = mysqlPassword;
    SharedPreferences.prefs
        .setString(Preferences.mysqlPassword.name, mysqlPassword);
    notifyListeners();
  }

  String _mysqlPath =
      SharedPreferences.prefs.getString(Preferences.mysqlPath.name) ?? '';
  String get mysqlPath => _mysqlPath;
  set mysqlPath(String mysqlPath) {
    _mysqlPath = mysqlPath;
    SharedPreferences.prefs.setString(Preferences.mysqlPath.name, mysqlPath);
    notifyListeners();
  }

  String _persistencePath =
      SharedPreferences.prefs.getString(Preferences.persistencePath.name) ?? '';
  String get persistencePath => _persistencePath;
  set persistencePath(String persistencePath) {
    _persistencePath = persistencePath;
    SharedPreferences.prefs
        .setString(Preferences.persistencePath.name, persistencePath);
    notifyListeners();
  }

  String _svnUsername =
      SharedPreferences.prefs.getString(Preferences.svnUsername.name) ?? '';
  String get svnUsername => _svnUsername;
  set svnUsername(String svnUsername) {
    _svnUsername = svnUsername;
    SharedPreferences.prefs
        .setString(Preferences.svnUsername.name, svnUsername);
    notifyListeners();
  }

  String _svnPassword =
      SharedPreferences.prefs.getString(Preferences.svnPassword.name) ?? '';
  String get svnPassword => _svnPassword;
  set svnPassword(String svnPassword) {
    _svnPassword = svnPassword;
    SharedPreferences.prefs
        .setString(Preferences.svnPassword.name, svnPassword);
    notifyListeners();
  }

  String _svnPath =
      SharedPreferences.prefs.getString(Preferences.svnPath.name) ?? '';
  String get svnPath => _svnPath;
  set svnPath(String svnPath) {
    _svnPath = svnPath;
    SharedPreferences.prefs.setString(Preferences.svnPath.name, svnPath);
    notifyListeners();
  }

  String _svnUrl =
      SharedPreferences.prefs.getString(Preferences.svnUrl.name) ?? '';
  String get svnUrl => _svnUrl;
  set svnUrl(String svnUrl) {
    _svnUrl = svnUrl;
    SharedPreferences.prefs.setString(Preferences.svnUrl.name, svnUrl);
    notifyListeners();
  }
}
