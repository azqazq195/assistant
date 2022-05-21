import 'package:flutter/foundation.dart';
import 'package:assistant/utils/shared_preferences.dart';

class Config extends ChangeNotifier {
  String _localPersistencePath = SharedPreferences.prefs
          .getString(Preferences.localPersistencePath.name) ??
      '';
  String get localPersistencePath => _localPersistencePath;
  set localPersistencePath(String localPersistencePath) {
    _localPersistencePath = localPersistencePath;
    SharedPreferences.prefs
        .setString(Preferences.localPersistencePath.name, localPersistencePath);
    notifyListeners();
  }

  String _author =
      SharedPreferences.prefs.getString(Preferences.author.name) ?? '';
  String get author => _author;
  set author(String author) {
    _author = author;
    SharedPreferences.prefs.setString(Preferences.author.name, author);
    notifyListeners();
  }

  List<String> _tableNames = [];
  List<String> get tableNames => _tableNames;
  set tableNames(List<String> tableNames) {
    _tableNames.clear();
    notifyListeners();
    _tableNames = tableNames;
    notifyListeners();
  }
}
