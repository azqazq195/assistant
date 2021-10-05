import 'package:sql_to_mapper/helpers/convertor.dart';

class Convertor {
  Table table;

  Convertor(this.table);

  String mapperInsert() {
    StringBuffer sb = StringBuffer();
    sb.write("insert into ${table.tableName} (\n");
    sb.write("\t${table.columns[0].name}");
    return sb.toString();
  }
}

class Table {
  late String tableName;
  List<Column> columns = [];

  Table(String code) {
    var string = code.split("\n");
    // 테이블 명 구하기.
    tableName = string[0]
        .substring(string[0].indexOf("`") + 1, string[0].lastIndexOf("`"));
    if (tableName.contains("`")) {
      tableName = tableName.substring(tableName.lastIndexOf("`") + 2);
    }

    // 컬럼 구하기.
    for (int i = 1; i < string.length; i++) {
      var temp = string[i].trim().split(" ");

      if (temp[0].indexOf("`") == 0) {
        String name = temp[0]
            .substring(temp[0].indexOf("`") + 1, temp[0].lastIndexOf("`"));
        String type = temp[1];
        if (!type.contains("TINYINT")) {
          type = type.replaceAll(RegExp(r"[^A-Z]"), "");
        }
        columns.add(Column(name, getType(type)));
      } else {
        // 기본키, 외래키 검수
        if (string[i].trim().indexOf("PRIMARY KEY") == 0) {
          String pk = string[i].substring(
              string[i].indexOf("`") + 1, string[i].lastIndexOf("`"));

          for (int k = 0; k < columns.length; k++) {
            if (columns[k].name == pk) {
              columns[k].isPK = true;
            }
          }
        }

        if (string[i].trim().indexOf("FOREIGN KEY") == 0) {
          String fk = string[i].substring(
              string[i].indexOf("`") + 1, string[i].lastIndexOf("`"));

          for (int k = 0; k < columns.length; k++) {
            if (columns[k].name == fk) {
              columns[k].isFK = true;
            }
          }
        }
      }
    }

    // 컬럼명 변수명으로 바꾸기
    for (int i = 0; i < columns.length; i++) {
      if (!columns[i].isPK && !columns[i].isFK) {
        columns[i].name = columns[i].name.substring(1);
      }

      var temp = columns[i].name.split("_");
      for (int k = 0; k < temp.length; k++) {
        if (k == 0) {
          columns[i].name = temp[k];
        } else {
          columns[i].name += temp[k][0].toUpperCase() + temp[k].substring(1);
        }
      }
    }
  }

  String getType(type) {
    switch (type) {
      case "INT":
        return "int";
      case "VARCHAR":
      case "TEXT":
        return "String";
      case "TIMESTAMP":
        return "Date";
      case "TINYINT":
        return "enum";
      case "TINYINT(1)":
        return "boolean";
      default:
        return "UNKNOWN";
    }
  }
}

class Column {
  String name;
  String type;
  bool isPK = false;
  bool isFK = false;

  Column(this.name, this.type);
}
