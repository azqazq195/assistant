class Convertor {
  DBTable table;

  Convertor(this.table);

  String domain() {
    String convertMethod(Column column) {
      String getIntMethod() {
        StringBuffer sb = StringBuffer();
        sb.write("""\tpublic int get${toCapitalize(column.javaName)}() {\n""");
        sb.write("""\t\treturn ${column.javaName};\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(int ${column.javaName}) {\n""");
        sb.write("""\t\tthis.${column.javaName} = ${column.javaName};\n""");
        sb.write("""\t}\n\n""");
        return sb.toString();
      }

      String getEnumMethod() {
        StringBuffer sb = StringBuffer();
        sb.write("""\tpublic int get${toCapitalize(column.javaName)}() {\n""");
        sb.write(
            """\t\treturn ${column.javaName} == null ? -1 : Enum.ordinal();\n""");
        sb.write("""\t}\n\n""");

        sb.write("""\tpublic Enum ${column.javaName}() {\n""");
        sb.write("""\t\treturn ${column.javaName};\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(int ${column.javaName}) {\n""");
        sb.write(
            """\t\tthis.${column.javaName} = Enum.values()[${column.javaName}];\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(Enum ${column.javaName}) {\n""");
        sb.write("""\t\tthis.${column.javaName} = ${column.javaName};\n""");
        sb.write("""\t}\n\n""");
        return sb.toString();
      }

      String getBooleanMethod() {
        StringBuffer sb = StringBuffer();
        sb.write("""\tpublic int get${toCapitalize(column.javaName)}() {\n""");
        sb.write("""\t\treturn ${column.javaName};\n""");
        sb.write("""\t}\n\n""");

        sb.write("""\tpublic boolean ${column.javaName}() {\n""");
        sb.write("""\t\treturn ${column.javaName} == 1;\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(int ${column.javaName}) {\n""");
        sb.write("""\t\tthis.${column.javaName} = ${column.javaName};\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(boolean ${column.javaName}) {\n""");
        sb.write(
            """\t\tthis.${column.javaName} = ${column.javaName} ? 1 : 0;\n""");
        sb.write("""\t}\n\n""");
        return sb.toString();
      }

      String getDateMethod() {
        StringBuffer sb = StringBuffer();
        sb.write("""\tpublic Date get${toCapitalize(column.javaName)}() {\n""");
        sb.write("""\t\treturn ${column.javaName};\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(Date ${column.javaName}) {\n""");
        sb.write("""\t\tthis.${column.javaName} = ${column.javaName};\n""");
        sb.write("""\t}\n\n""");
        return sb.toString();
      }

      String getStringMethod() {
        StringBuffer sb = StringBuffer();
        sb.write(
            """\tpublic String get${toCapitalize(column.javaName)}() {\n""");
        sb.write("""\t\treturn ${column.javaName};\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(String ${column.javaName}) {\n""");
        sb.write("""\t\tthis.${column.javaName} = ${column.javaName};\n""");
        sb.write("""\t}\n\n""");
        return sb.toString();
      }

      String getBigDecimalMethod() {
        StringBuffer sb = StringBuffer();
        sb.write(
            """\tpublic BigDecimal get${toCapitalize(column.javaName)}() {\n""");
        sb.write("""\t\treturn ${column.javaName}\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(BigDecimal ${column.javaName}) {\n""");
        sb.write("""\t\tthis.${column.javaName} = ${column.javaName};\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(long ${column.javaName}) {\n""");
        sb.write(
            """\t\tthis.${column.javaName} = BigDecimal.valueOf(${column.javaName});\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(double ${column.javaName}) {\n""");
        sb.write(
            """\t\tthis.${column.javaName} = BigDecimal.valueOf(${column.javaName});\n""");
        sb.write("""\t}\n\n""");
        return sb.toString();
      }

      switch (column.javaType) {
        case "int":
          return getIntMethod();
        case "enum":
          return getEnumMethod();
        case "boolean":
          return getBooleanMethod();
        case "String":
          return getStringMethod();
        case "Date":
          return getDateMethod();
        case "BigDecimal":
          return getBigDecimalMethod();
        default:
          return "UNKNOWN";
      }
    }

    String getDomainType(String type) {
      switch (type) {
        case "int":
        case "boolean":
        case "enum":
          return "int";
        case "String":
          return "String";
        case "Date":
          return "Date";
        case "BigDecimal":
          return "BigDecimal";
        default:
          return "UNKNOWN";
      }
    }

    StringBuffer sb = StringBuffer();
    sb.write("""public class ${toCapitalize(table.domain)} {\n""");
    for (Column column in table.columns) {
      sb.write(
          """\tprivate ${getDomainType(column.javaType)} ${column.javaName}""");
      if (getNullType(column.javaType) != "null") {
        sb.write(" = ${getNullType(column.javaType)};\n");
      } else {
        sb.write(";\n");
      }
    }
    sb.write("\n");

    for (Column column in table.columns) {
      sb.write(convertMethod(column));
    }
    sb.write("""}""");
    return sb.toString();
  }

  String mapper() {
    String hasId() {
      StringBuffer sb = StringBuffer();
      sb.write(
          """public void insert${table.domain}(@Param("siteName") String siteName, @Param("value") ${table.domain} value);\n""");
      sb.write(
          """public void get${table.domain}(@Param("siteName") String siteName, @Param("id") int id);\n""");
      sb.write(
          """public void update${table.domain}(@Param("siteName") String siteName, @Param("value") ${table.domain} value);\n""");
      sb.write(
          """public void delete${table.domain}(@Param("siteName") String siteName, @Param("id") int id);""");
      return sb.toString();
    }

    String hasNotId() {
      StringBuffer sb = StringBuffer();
      sb.write(
          """public void insert${table.domain}(@Param("siteName") String siteName, @Param("value") ${table.domain} value);\n""");
      sb.write(
          """public void get${table.domain}(@Param("siteName") String siteName, @Param("option") ${table.domain} option);\n""");
      sb.write(
          """public void update${table.domain}(@Param("siteName") String siteName, @Param("option") ${table.domain} option);\n""");
      sb.write(
          """public void delete${table.domain}(@Param("siteName") String siteName, @Param("option") ${table.domain} option);""");
      return sb.toString();
    }

    if (table.hasAI && table.hasId) {
      return hasId();
    } else {
      return hasNotId();
    }

  }

  String mybatis() {
    String hasId() {
      String mybatisInsert() {
        StringBuffer sb = StringBuffer();
        sb.write(
            """<insert id="insert${table.domain}" useGeneratedKeys="true" keyProperty="value.id">\n""");
        sb.write("""\tinsert into \${siteName}.c${table.tableName} (\n""");
        sb.write("""\t\t<trim suffixOverrides=",">\n""");
        for (Column column in table.columns) {
          if (column.javaName == "id") continue;
          if(column.isFK) {
            sb.write(
                """\t\t\t${column.dbName},\n""");
          } else {
            sb.write(
                """\t\t\t<if test="value.${column.javaName} != ${getNullType(column.javaType)}">${column.dbName},</if>\n""");
          }
        }
        sb.write("""\t\t</trim>\n""");
        sb.write("""\t) values (\n""");
        sb.write("""\t\t<trim suffixOverrides=",">\n""");
        for (Column column in table.columns) {
          if (column.javaName == "id") continue;
          if(column.isFK) {
            sb.write(
                """\t\t\t#{value.${column.javaName}},\n""");
          } else {
            sb.write(
                """\t\t\t<if test="value.${column.javaName} != ${getNullType(column.javaType)}">#{value.${column.javaName}},</if>\n""");
          }
        }
        sb.write("""\t\t</trim>\n""");
        sb.write("""\t)\n""");
        sb.write("""</insert>""");

        return sb.toString();
      }

      String mybatisSelect() {
        StringBuffer sb = StringBuffer();
        sb.write(
            """<select id="get${table.domain}" resultType="${table.domain}">\n""");
        sb.write("""\tselect\n""");
        for (Column column in table.columns) {
          sb.write('\t\t${column.dbName} as "${column.javaName}"');
          if(column != table.columns.last) {
            sb.write(",");
          }
          sb.write("\n");
        }
        sb.write("""\tfrom\n""");
        sb.write("""\t\t\${siteName}.c${table.tableName}\n""");
        sb.write("""\twhere\n""");
        sb.write("""\t\tid = \${id}\n""");
        sb.write("""</select>""");

        return sb.toString();
      }

      String mybatisUpdate() {
        StringBuffer sb = StringBuffer();
        sb.write("""<update id="update${table.domain}">\n""");
        sb.write("""\tupdate \${siteName}.c${table.tableName}\n""");
        sb.write("""\t<set>\n""");
        for (Column column in table.columns) {
          if (column.dbName == "id") continue;
          sb.write(
              """\t\t<if test="value.${column.javaName} != ${getNullType(column.javaType)}">${column.dbName} = #{value.${column.javaName}},</if>\n""");
        }
        sb.write("""\t</set>\n""");
        sb.write("""\twhere id = #{value.id}\n""");
        sb.write("""</update>""");
        return sb.toString();
      }

      String mybatisDelete() {
        StringBuffer sb = StringBuffer();
        sb.write("""<delete id="delete${table.domain}">\n""");
        sb.write("""\tdelete from \${siteName}.c${table.tableName}\n""");
        sb.write("""\twhere\n""");
        sb.write("""\t\tid=\${id}\n""");
        sb.write("""</delete>""");
        return sb.toString();
      }

      return mybatisInsert() +
          "\n\n" +
          mybatisSelect() +
          "\n\n" +
          mybatisUpdate() +
          "\n\n" +
          mybatisDelete();
    }

    String hasNotId() {
      String mybatisInsert() {
        StringBuffer sb = StringBuffer();
        if (table.hasAI) {
          sb.write("""<insert id="insert${table.domain}">\n""");
        }
        sb.write("""\tinsert into \${siteName}.c${table.tableName} (\n""");
        sb.write("""\t\t<trim suffixOverrides=",">\n""");
        for (Column column in table.columns) {
          sb.write(
              """\t\t\t<if test="value.${column.javaName} != ${getNullType(column.javaType)}">${column.dbName},</if>\n""");
        }
        sb.write("""\t\t</trim>\n""");
        sb.write("""\t) values (\n""");
        sb.write("""\t\t<trim suffixOverrides=",">\n""");
        for (Column column in table.columns) {
          sb.write(
              """\t\t\t<if test="value.${column.javaName} != ${getNullType(column.javaType)}">#{value.${column.javaName}},</if>\n""");
        }
        sb.write("""\t\t</trim>\n""");
        sb.write("""\t)\n""");
        sb.write("""</insert>""");
        return sb.toString();
      }

      String mybatisSelect() {
        StringBuffer sb = StringBuffer();
        sb.write(
            """<select id="get${table.domain}" resultType="${table.domain}">\n""");
        sb.write("""\tselect\n""");
        for (Column column in table.columns) {
          sb.write("""\t\t${column.dbName} as "${column.javaName}"\n""");
        }
        sb.write("""\tfrom\n""");
        sb.write("""\t\t\${siteName}.c${table.tableName}\n""");
        sb.write("""\twhere\n""");
        sb.write("""\t\t<trim prefixOverrides="and">\n""");
        for (Column column in table.columns) {
          sb.write(
              """\t\t\t<if test="option.${column.javaName} != ${getNullType(column.javaType)}">and ${column.dbName} = #{option.${column.javaName}},</if>\n""");
        }
        sb.write("""\t\t</trim>\n""");
        sb.write("""</select>""");

        return sb.toString();
      }

      String mybatisUpdate() {
        StringBuffer sb = StringBuffer();
        sb.write("""<update id="update${table.domain}">\n""");
        sb.write("""\tupdate \${siteName}.c${table.tableName}\n""");
        sb.write("""\t<set>\n""");
        for (Column column in table.columns) {
          if (column.dbName == "id") continue;
          sb.write(
              """\t\t<if test="value.${column.javaName} != ${getNullType(column.javaType)}">${column.dbName} = #{value.${column.javaName}},</if>\n""");
        }
        sb.write("""\t</set>\n""");
        sb.write("""\twhere\n""");
        sb.write("""\t\t<trim prefixOverrides="and">\n""");
        for (Column column in table.columns) {
          sb.write(
              """\t\t\t<if test="option.${column.javaName} != ${getNullType(column.javaType)}">and ${column.dbName} = #{option.${column.javaName}},</if>\n""");
        }
        sb.write("""\t\t</trim>\n""");
        sb.write("""</update>""");
        return sb.toString();
      }

      String mybatisDelete() {
        StringBuffer sb = StringBuffer();
        sb.write("""<delete id="delete${table.domain}">\n""");
        sb.write("""\tdelete from \${siteName}.c${table.tableName}\n""");
        sb.write("""\twhere\n""");
        sb.write("""\t\t<trim prefixOverrides="and">\n""");
        for (Column column in table.columns) {
          sb.write(
              """\t\t\t<if test="option.${column.javaName} != ${getNullType(column.javaType)}">and ${column.dbName} = #{option.${column.javaName}},</if>\n""");
        }
        sb.write("""\t\t</trim>\n""");
        sb.write("""</delete>""");
        return sb.toString();
      }

      return mybatisInsert() +
          "\n\n" +
          mybatisSelect() +
          "\n\n" +
          mybatisUpdate() +
          "\n\n" +
          mybatisDelete();
    }

    if (table.hasAI && table.hasId) {
      return hasId();
    } else {
      return hasNotId();
    }
  }

  String getNullType(String type) {
    switch (type) {
      case "int":
      case "enum":
      case "boolean":
        return "-1";
      case "String":
      case "Date":
      case "BigDecimal":
      default:
        return "null";
    }
  }

  String toCapitalize(str) {
    return str[0].toUpperCase() + str.substring(1);
  }

  String toCamel(str) {
    var result = "";
    var temp = str.split("_");
    for (int k = 0; k < temp.length; k++) {
      if (k == 0) {
        result = temp[k];
      } else {
        result = result + temp[k][0].toUpperCase() + temp[k].substring(1);
      }
    }
    return result;
  }
}

class DBTable {
  late String tableName;
  late String domain;
  bool hasAI = false;
  bool hasId = false;
  List<Column> columns = [];

  DBTable(String code) {
    var strings = code.split("\n");

    for (String string in strings) {
      string = string.trim();
      // 테이블 명 구하기.
      if (string.startsWith("CREATE")) {
        tableName =
            string.substring(string.indexOf("`") + 1, string.lastIndexOf("`"));
        if (tableName.contains("`")) {
          tableName = tableName.substring(tableName.lastIndexOf("`") + 2);
        }
        domain = toCapitalize(toCamel(tableName));
      }

      // 컬럼 구하기.
      if (string.startsWith("`")) {
        bool isAI = false;
        bool isNullable = false;
        if (string.contains("AUTO_INCREMENT")) {
          hasAI = true;
          isAI = true;
        }
        if (string.contains("NOT NULL")) {
          isNullable = false;
        } else if (string.contains("NULL")) {
          isNullable = true;
        }
        var temp = string.split(" ");
        String name = temp[0]
            .substring(temp[0].indexOf("`") + 1, temp[0].lastIndexOf("`"));
        String type = temp[1];
        if (!type.contains("TINYINT")) {
          type = type.replaceAll(RegExp(r"[^A-Z]"), "");
        }
        columns.add(Column(name, type, getType(type), isAI, isNullable));
      }

      // 기본키, 외래키 검수
      if (string.indexOf("PRIMARY KEY") == 0) {
        String pk =
            string.substring(string.indexOf("`") + 1, string.lastIndexOf("`"));
        for (int k = 0; k < columns.length; k++) {
          if (columns[k].dbName == pk) {
            columns[k].isPK = true;
          }
        }
      }

      if (string.indexOf("FOREIGN KEY") == 0) {
        String fk =
            string.substring(string.indexOf("`") + 1, string.lastIndexOf("`"));
        for (int k = 0; k < columns.length; k++) {
          if (columns[k].dbName == fk) {
            columns[k].isFK = true;
          }
        }
      }
    }

    // 디비 컬럼명 자바 변수명으로 바꾸기
    for (int i = 0; i < columns.length; i++) {
      var temp = columns[i].dbName.split("_");
      for (int k = 0; k < temp.length; k++) {
        if (k == 0) {
          columns[i].javaName = temp[k];
        } else {
          columns[i].javaName = columns[i].javaName! +
              temp[k][0].toUpperCase() +
              temp[k].substring(1);
        }
      }

      if (!columns[i].isPK && !columns[i].isFK) {
        columns[i].javaName = columns[i].javaName!.substring(1);
      }
    }

    for (Column column in columns) {
      if (column.dbName == "id") {
        hasId = true;
        break;
      }
    }
  }

  String toCapitalize(str) {
    return str[0].toUpperCase() + str.substring(1);
  }

  String toCamel(str) {
    var result = "";
    var temp = str.split("_");
    for (int k = 0; k < temp.length; k++) {
      if (k == 0) {
        result = temp[k];
      } else {
        result = result + temp[k][0].toUpperCase() + temp[k].substring(1);
      }
    }
    return result;
  }

  String getType(type) {
    switch (type) {
      case "INT":
        return "int";
      case "TINYINT":
        return "enum";
      case "TINYINT(1)":
      case "bool":
        return "boolean";
      case "VARCHAR":
      case "TEXT":
        return "String";
      case "DECIMAL":
        return "BigDecimal";
      case "TIMESTAMP":
        return "Date";
      default:
        return "UNKNOWN";
    }
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
