class Convertor {
  static String convertMapper(String code) {
    Table table = convert(code);

    return "dd";
  }

  static Table convert(String code) {
    RegExp regExp = RegExp(r"[\`][a-z]*[\`]");
    var string = code.split("\n");
    String? name;

    // 테이블 명 구하기.
    if (regExp.hasMatch(string[0])) {
      name = string[0].substring(regExp.firstMatch(string[0])!.end);
      name = name.substring(
          regExp.firstMatch(name)!.start, regExp.firstMatch(name)!.end);
      name = name.replaceAll("`", "");
      if (name[0] == 'c') {
        name = name.substring(1);
      }
    }
    if (name == null) throw Error();
    Table table = Table(name, []);

    // 컬럼 구하기.
    for (var i = 1; i < string.length; i++) {
      String temp = string[i].trim();
      if (temp.indexOf("`") == 0) {
        var line = temp.split(" ");
        String itemName = line[0];
        itemName = itemName.replaceAll("`", "");

        String itemType = line[1];
        itemType = itemType.replaceAll("[0-9]", "");
        table.columns.add(Item(itemName, itemType));
        continue;
      }
    }

    print(table.toString());
    return table;
  }
}

class Table {
  String name;
  List<Item> columns;

  Table(this.name, this.columns);

  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.write(name);
    sb.write("\n");
    for (Item column in columns) {
      sb.write(column.toString());
    }
    return sb.toString();
  }
}

class Item {
  String name;
  String type;

  Item(this.name, this.type);

  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.write(name);
    sb.write(": ");
    sb.write(type);
    sb.write("\n");
    return sb.toString();
  }
}
