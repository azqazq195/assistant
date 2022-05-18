import 'dart:collection';
import 'package:assistant/utils/convertor.dart' as db;
import 'package:flutter/foundation.dart';

class Database with ChangeNotifier {
  Database() {
    loadDatabase(db.Schema.csttec);
  }

  Future<void> loadDatabase(schema) async {
    localTableList =
        await db.Database().loadDatabase(db.Location.local, schema);
    svnTableList = await db.Database().loadDatabase(db.Location.svn, schema);
    loadAllTableDomainList();
    notifyListeners();
  }

  final List<String> _allTableDomainList = [];

  List<db.Table> _localTableList = [];
  final List<String> _localTableDomainList = [];
  final Map<String, db.Table> _localTableMap = HashMap();
  final Map<String, List<db.Column>> _localColumnMap = HashMap();
  List<db.Column> _localColumnList = [];

  List<db.Table> _svnTableList = [];
  final List<String> _svnTableDomainList = [];
  final Map<String, db.Table> _svnTableMap = HashMap();
  final Map<String, List<db.Column>> _svnColumnMap = HashMap();
  List<db.Column> _svnColumnList = [];

  List<db.Table> get localTableList => _localTableList;
  set localTableList(List<db.Table> tableList) {
    _localTableList = tableList;
    _localTableDomainList.clear();
    _localTableMap.clear();

    for (var table in _localTableList) {
      _localTableDomainList.add(table.domain);
      _localTableMap[table.domain] = table;
      _localColumnMap[table.domain] = table.columns;
    }
    notifyListeners();
  }

  List<db.Table> get svnTableList => _svnTableList;
  set svnTableList(List<db.Table> tableList) {
    _svnTableList = tableList;
    _svnTableDomainList.clear();
    _svnTableMap.clear();

    for (var table in _svnTableList) {
      _svnTableDomainList.add(table.domain);
      _svnTableMap[table.domain] = table;
      _svnColumnMap[table.domain] = table.columns;
    }
    notifyListeners();
  }

  void loadAllTableDomainList() {
    _allTableDomainList.clear();
    for (var domain in _localTableDomainList) {
      _allTableDomainList.add(domain);
    }
    for (var domain in _svnTableDomainList) {
      if (!_allTableDomainList.contains(domain)) {
        _allTableDomainList.add(domain);
      }
    }
    _allTableDomainList.sort((a, b) => a.compareTo(b));
    notifyListeners();
  }

  List<String> get allTableDomainList => _allTableDomainList;
  List<String> get localTableDomainList => _localTableDomainList;
  List<String> get svnTableDomainList => _svnTableDomainList;

  List<db.Column> get localColumnList => _localColumnList;
  void setLocalColumnList(String tableDomain) {
    _localColumnList = _localColumnMap[tableDomain] ?? [];
    notifyListeners();
  }

  List<db.Column> get svnColumnList => _svnColumnList;
  void setSvnColumnList(String tableDomain) {
    _svnColumnList = _svnColumnMap[tableDomain] ?? [];
    notifyListeners();
  }

  db.Table? getLocalTable(String tableDomain) {
    return _localTableMap[tableDomain];
  }

  db.Table? getSvnTable(String tableDomain) {
    return _svnTableMap[tableDomain];
  }
}
