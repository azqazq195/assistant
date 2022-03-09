import 'dart:io';

import 'package:fluent/provider/database.dart';
import 'package:fluent/utils/logger.dart';
import 'package:fluent/utils/shared_preferences.dart';
import 'package:fluent/utils/utils.dart';

enum Schema { csttec, center }

class Convertor {
  final database = Database();

  Future<List<String>> loadDatabase(Schema schema) async {
    var filePath =
        SharedPreferences.prefs.getString(Preferences.persistencePath.name) ??
            '';
    switch (schema) {
      case Schema.csttec:
        filePath += '\\db-populate.sql';
        break;
      case Schema.center:
        filePath += '\\center-db-populate.sql';
        break;
      default:
        break;
    }

    File sqlFile = File(filePath);

    final sqlContents = await sqlFile.readAsString();

    String code = "";
    bool insert = false;
    List<Table> tableList = [];

    for (String sqlContent in sqlContents.split("\n")) {
      if (sqlContent.toUpperCase().startsWith("CREATE TABLE")) {
        insert = true;
      }

      if (insert) {
        code += sqlContent + "\n";
      }

      if (sqlContent.contains(";")) {
        if (code.isEmpty) {
          continue;
        }
        tableList.add(Table(code));
        code = "";
        insert = false;
      }
    }

    List<String> tableDomainList = [];
    for (Table table in tableList) {
      print(table.tableName);
      print(table.domain);
      tableDomainList.add(table.domain);
    }
    tableDomainList.sort((a, b) => a.compareTo(b));
    return tableDomainList;
  }
}

class Table {
  late String tableName;
  late String domain;
  bool hasAI = false;
  bool hasId = false;
  List<Column> columns = [];

  Table(String code) {
    final strings = code.split("\n");
    var temp = strings[0].trim();
    temp = temp.substring(0, temp.lastIndexOf("`"));

    tableName = temp.substring(temp.lastIndexOf("`") + 2);
    domain = toCapitalize(toCamel(tableName));

    //   for (String string in code.split("\n")) {
    //     string = string.trim();
    //     print(string);
    //     // 테이블 명 구하기.
    //     if (string.startsWith("CREATE")) {
    //       tableName =
    //           string.substring(string.indexOf("`") + 1, string.lastIndexOf("`"));
    //       if (tableName.contains("`")) {
    //         tableName = tableName.substring(tableName.lastIndexOf("`") + 2);
    //       }
    //       domain = toCapitalize(toCamel(tableName));
    //     }

    //     // 컬럼 구하기.
    //     if (string.startsWith("`")) {
    //       bool isAI = false;
    //       bool isNullable = false;
    //       if (string.contains("AUTO_INCREMENT")) {
    //         hasAI = true;
    //         isAI = true;
    //       }
    //       if (string.contains("NOT NULL")) {
    //         isNullable = false;
    //       } else if (string.contains("NULL")) {
    //         isNullable = true;
    //       }
    //       var temp = string.split(" ");
    //       String name = temp[0]
    //           .substring(temp[0].indexOf("`") + 1, temp[0].lastIndexOf("`"));
    //       String type = temp[1];
    //       if (!type.contains("TINYINT")) {
    //         type = type.replaceAll(RegExp(r"[^A-Z]"), "");
    //       }
    //       columns.add(Column(name, type, getType(type), isAI, isNullable));
    //     }

    //     // 기본키, 외래키 검수
    //     if (string.indexOf("PRIMARY KEY") == 0) {
    //       String pk =
    //           string.substring(string.indexOf("`") + 1, string.lastIndexOf("`"));
    //       for (int k = 0; k < columns.length; k++) {
    //         if (columns[k].dbName == pk) {
    //           columns[k].isPK = true;
    //         }
    //       }
    //     }

    //     if (string.indexOf("FOREIGN KEY") == 0) {
    //       String fk =
    //           string.substring(string.indexOf("`") + 1, string.lastIndexOf("`"));
    //       for (int k = 0; k < columns.length; k++) {
    //         if (columns[k].dbName == fk) {
    //           columns[k].isFK = true;
    //         }
    //       }
    //     }
    //   }

    //   // 디비 컬럼명 자바 변수명으로 바꾸기
    //   for (int i = 0; i < columns.length; i++) {
    //     var temp = columns[i].dbName.split("_");
    //     for (int k = 0; k < temp.length; k++) {
    //       if (k == 0) {
    //         columns[i].javaName = temp[k];
    //       } else {
    //         columns[i].javaName = columns[i].javaName! +
    //             temp[k][0].toUpperCase() +
    //             temp[k].substring(1);
    //       }
    //     }

    //     if (!columns[i].isPK && !columns[i].isFK) {
    //       columns[i].javaName = columns[i].javaName!.substring(1);
    //     }
    //   }

    //   for (Column column in columns) {
    //     if (column.dbName == "id") {
    //       hasId = true;
    //       break;
    //     }
    //   }
    // }

    // String getType(type) {
    //   switch (type) {
    //     case "INT":
    //       return "int";
    //     case "DOUBLE":
    //       return "double";
    //     case "TINYINT":
    //       return "enum";
    //     case "TINYINT(1)":
    //     case "bool":
    //       return "boolean";
    //     case "VARCHAR":
    //     case "TEXT":
    //       return "String";
    //     case "DECIMAL":
    //       return "BigDecimal";
    //     case "TIMESTAMP":
    //       return "Date";
    //     default:
    //       return "UNKNOWN";
    //   }
  }

  @override
  String toString() {
    String getSpace(String? str) {
      if (str == null) return "\t\t\t\t\t";
      if (str.length >= 16) {
        return str + "\t";
      }
      if (str.length >= 12) {
        return str + "\t\t";
      }
      if (str.length >= 8) {
        return str + "\t\t\t";
      }
      if (str.length >= 4) {
        return str + "\t\t\t\t";
      }
      return str + "\t\t\t\t\t";
    }

    StringBuffer sb = StringBuffer();
    sb.write("\n\n---[TABLE]---\n");
    sb.write("tableName: $tableName\n");
    sb.write("domain: $domain\n");
    sb.write("hasAI: $hasAI\n");
    sb.write(getSpace("[dbName]"));
    sb.write(getSpace("[javaName]"));
    sb.write(getSpace("[type]"));
    sb.write(getSpace("[isAI]"));
    sb.write(getSpace("[isNullable]"));
    sb.write(getSpace("[isPK]"));
    sb.write(getSpace("[isFK]"));
    sb.write("\n");
    for (Column column in columns) {
      sb.write(getSpace(column.dbName));
      sb.write(getSpace(column.javaName));
      sb.write(getSpace(column.javaType));
      sb.write(getSpace(column.isAI.toString()));
      sb.write(getSpace(column.isNullable.toString()));
      sb.write(getSpace(column.isPK.toString()));
      sb.write(getSpace(column.isFK.toString()));
      sb.write("\n");
    }
    return sb.toString();
  }
}

class Column {
  String dbName;
  String? javaName;
  String dbType;
  String javaType;

  bool isAI;
  bool isNullable;
  bool isPK = false;
  bool isFK = false;

  Column(this.dbName, this.dbType, this.javaType, this.isAI, this.isNullable);
}
