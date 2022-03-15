import 'dart:collection';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent/utils/convertor.dart' as db;

class LoacalDatabase extends Database {
  LoacalDatabase() {
    _init();
  }

  Future<void> _init() async {
    tableList =
        await db.Database().loadDatabase(db.Location.local, db.Schema.csttec);
    notifyListeners();
  }
}

class SvnDatabase extends Database {
  SvnDatabase() {
    _init();
  }

  Future<void> _init() async {
    tableList =
        await db.Database().loadDatabase(db.Location.svn, db.Schema.csttec);
    notifyListeners();
  }
}

class Database with ChangeNotifier {
  List<db.Table> _tableList = [];
  List<db.Table> get tableList => _tableList;
  set tableList(List<db.Table> tableList) {
    _tableList = tableList;
    _tableNameList.clear();
    _tableDomainList.clear();
    _tableMap.clear();
    for (var table in _tableList) {
      _tableNameList.add(table.tableName);
      _tableDomainList.add(table.domain);
      _columnMap[table.domain] = table.columns;
      _tableMap[table.domain] = table;
    }
    _tableNameList.sort((a, b) => a.compareTo(b));
    _tableDomainList.sort((a, b) => a.compareTo(b));
    notifyListeners();
  }

  final List<String> _tableNameList = [];
  List<String> get tableNameList => _tableNameList;

  final List<String> _tableDomainList = [];
  List<String> get tableDomainList => _tableDomainList;

  final Map<String, db.Table> _tableMap = HashMap();

  final Map<String, List<db.Column>> _columnMap = HashMap();

  List<db.Column> _columnList = [];
  List<db.Column> get columnList => _columnList;
  set columnList(List<db.Column> columnList) {
    _columnList = columnList;
    notifyListeners();
  }

  void setColumnList(String tableDomain) {
    columnList = _columnMap[tableDomain] ?? [];
    notifyListeners();
  }

  db.Table? getTable(String tableDomain) {
    return _tableMap[tableDomain];
  }
}
