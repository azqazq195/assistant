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

  List<String> _tableNames = [];
  List<String> get tableNames => _tableNames;
  set tableNames(List<String> tableNames) {
    _tableNames.clear();
    notifyListeners();
    _tableNames = tableNames;
    notifyListeners();
  }
}
