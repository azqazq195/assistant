import 'dart:collection';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent/utils/convertor.dart' as convertor;

class Database extends ChangeNotifier {
  List<convertor.Table> _tableList = [];
  List<convertor.Table> get tableList => _tableList;
  set tableList(List<convertor.Table> tableList) {
    _tableList = tableList;
    _tableNameList.clear();
    _tableDomainList.clear();
    for (var table in _tableList) {
      _tableNameList.add(table.tableName);
      _tableDomainList.add(table.domain);
      _columnMap[table.domain] = table.columns;
    }
    _tableNameList.sort((a, b) => a.compareTo(b));
    _tableDomainList.sort((a, b) => a.compareTo(b));
    notifyListeners();
  }

  final List<String> _tableNameList = [];
  List<String> get tableNameList => _tableNameList;

  final List<String> _tableDomainList = [];
  List<String> get tableDomainList => _tableDomainList;

  final Map<String, List<convertor.Column>> _columnMap = HashMap();

  List<convertor.Column> _columnList = [];
  List<convertor.Column> get columnList => _columnList;
  set columnList(List<convertor.Column> columnList) {
    _columnList = columnList;
    notifyListeners();
  }

  void setColumnList(String tableDomain) {
    columnList = _columnMap[tableDomain] ?? [];
    notifyListeners();
  }
}
