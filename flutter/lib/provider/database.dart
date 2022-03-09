import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

class Database extends ChangeNotifier {
  List<String> _tableList = [];
  List<String> get tableList => _tableList;
  set tableList(List<String> tableList) {
    _tableList = tableList;
    notifyListeners();
  }
}
