import 'dart:io';

import 'package:assistant/utils/logger.dart';
import 'package:assistant/utils/shared_preferences.dart';
import 'package:assistant/utils/utils.dart';

enum Schema { csttec, center }

enum Location { local, svn }

class Convertor {
  Table table;

  Convertor(this.table);

  String domain() {
    bool hasBigDecimal = false;
    bool hasEnum = false;
    bool hasDate = false;

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

      String getDoubleMethod() {
        StringBuffer sb = StringBuffer();
        sb.write(
            """\tpublic double get${toCapitalize(column.javaName)}() {\n""");
        sb.write("""\t\treturn ${column.javaName};\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(double ${column.javaName}) {\n""");
        sb.write("""\t\tthis.${column.javaName} = ${column.javaName};\n""");
        sb.write("""\t}\n\n""");
        return sb.toString();
      }

      String getEnumMethod() {
        StringBuffer sb = StringBuffer();
        sb.write("""\tpublic int get${toCapitalize(column.javaName)}() {\n""");
        sb.write(
            """\t\treturn ${column.javaName} == null ? -1 : ${column.javaName}.ordinal();\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic ${toCapitalize(column.javaName)} ${column.javaName}() {\n""");
        sb.write("""\t\treturn ${column.javaName};\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(int ${column.javaName}) {\n""");
        sb.write(
            """\t\tthis.${column.javaName} = ${toCapitalize(column.javaName)}.values()[${column.javaName}];\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(String ${column.javaName}) {\n""");
        sb.write(
            """\t\tthis.${column.javaName} = ${toCapitalize(column.javaName)}.valueOf(${column.javaName});\n""");
        sb.write("""\t}\n\n""");

        sb.write(
            """\tpublic void set${toCapitalize(column.javaName)}(${toCapitalize(column.javaName)} ${column.javaName}) {\n""");
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
        case "double":
          return getDoubleMethod();
        case "enum":
          hasEnum = true;
          return getEnumMethod();
        case "boolean":
          return getBooleanMethod();
        case "String":
          return getStringMethod();
        case "Date":
          hasDate = true;
          return getDateMethod();
        case "BigDecimal":
          hasBigDecimal = true;
          return getBigDecimalMethod();
        default:
          return "UNKNOWN";
      }
    }

    String getDomainType(Column column) {
      switch (column.javaType) {
        case "int":
        case "boolean":
          return "int";
        case "double":
          return "double";
        case "String":
          return "String";
        case "Date":
          return "Date";
        case "BigDecimal":
          return "BigDecimal";
        case "enum":
          return toCapitalize(column.javaName);
        default:
          return "UNKNOWN";
      }
    }

    StringBuffer sb = StringBuffer();
    for (Column column in table.columns) {
      sb.write("""\tprivate ${getDomainType(column)} ${column.javaName}""");
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

    StringBuffer prefix = StringBuffer();
    prefix.write("package com.csttec.server.domain;\n\n");
    if (hasBigDecimal) {
      prefix.write("import java.math.BigDecimal;\n");
    }
    if (hasDate) {
      prefix.write("import java.util.Date;\n");
    }
    if (hasBigDecimal || hasDate) {
      prefix.write("\n");
    }

    prefix.write("""public class ${toCapitalize(table.domain)} {\n\n""");
    if (hasEnum) {
      for (Column column in table.columns) {
        if (column.javaType == "enum") {
          prefix.write(
              "\tpublic enum ${toCapitalize(column.javaName)} {\n\n\t}\n\n");
        }
      }
    }

    return prefix.toString() + sb.toString();
  }

  String mapper() {
    String hasId() {
      StringBuffer sb = StringBuffer();
      sb.write(
          """public void insert${table.domain}(@Param("siteName") String siteName, @Param("value") ${table.domain} value);\n""");
      sb.write(
          """public ${table.domain} get${table.domain}(@Param("siteName") String siteName, @Param("id") int id);\n""");
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
          """public ${table.domain} get${table.domain}(@Param("siteName") String siteName, @Param("option") ${table.domain} option);\n""");
      sb.write(
          """public void update${table.domain}(@Param("siteName") String siteName, @Param("value") ${table.domain} value);\n""");
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
    String hasAI() {
      String mybatisInsert() {
        StringBuffer sb = StringBuffer();
        sb.write(
            """<insert id="insert${table.domain}" useGeneratedKeys="true" keyProperty="value.id">\n""");
        sb.write("""\tinsert into \${siteName}.c${table.tableName} (\n""");
        sb.write("""\t\t<trim suffixOverrides=",">\n""");
        for (Column column in table.columns) {
          if (column.javaName == "id") continue;
          if (column.isFK) {
            sb.write("""\t\t\t${column.dbName},\n""");
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
          if (column.isFK) {
            sb.write("""\t\t\t#{value.${column.javaName}},\n""");
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
          if (column != table.columns.last) {
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
        sb.write("""\twhere\n""");
        sb.write("""\t\tid = #{value.id}\n""");
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

      return "${mybatisInsert()}\n\n${mybatisSelect()}\n\n${mybatisUpdate()}\n\n${mybatisDelete()}";
    }

    String hasNotAI() {
      String mybatisInsert() {
        StringBuffer sb = StringBuffer();
        if (table.hasId) {
          sb.write(
              """<insert id="insert${table.domain}" useGeneratedKeys="true" keyProperty="value.id">\n""");
        } else {
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
          sb.write('\t\t${column.dbName} as "${column.javaName}"');
          if (column != table.columns.last) {
            sb.write(",");
          }
          sb.write("\n");
        }
        sb.write("""\tfrom\n""");
        sb.write("""\t\t\${siteName}.c${table.tableName}\n""");
        sb.write("""\t<where>\n""");
        for (Column column in table.columns) {
          sb.write(
              """\t\t<if test="option.${column.javaName} != ${getNullType(column.javaType)}">and ${column.dbName} = #{option.${column.javaName}}</if>\n""");
        }
        sb.write("""\t</where>\n""");
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
        sb.write("""\t<where>\n""");
        for (Column column in table.columns) {
          sb.write(
              """\t\t<if test="value.${column.javaName} != ${getNullType(column.javaType)}">and ${column.dbName} = #{value.${column.javaName}}</if>\n""");
        }
        sb.write("""\t</where>\n""");
        sb.write("""</update>""");
        return sb.toString();
      }

      String mybatisDelete() {
        StringBuffer sb = StringBuffer();
        sb.write("""<delete id="delete${table.domain}">\n""");
        sb.write("""\tdelete from \${siteName}.c${table.tableName}\n""");
        sb.write("""\t<where>\n""");
        for (Column column in table.columns) {
          sb.write(
              """\t\t\t<if test="option.${column.javaName} != ${getNullType(column.javaType)}">and ${column.dbName} = #{option.${column.javaName}}</if>\n""");
        }
        sb.write("""\t</where>\n""");
        sb.write("""</delete>""");
        return sb.toString();
      }

      return "${mybatisInsert()}\n\n${mybatisSelect()}\n\n${mybatisUpdate()}\n\n${mybatisDelete()}";
    }

    if (table.hasAI && table.hasId) {
      return hasAI();
    } else {
      return hasNotAI();
    }
  }

  List<Map<String, String>> service(String packageName, String author) {
    List methods = ['Create', 'Delete', 'Edit', 'List', 'Add', 'Remove'];
    List<Map<String, String>> services = [];
    for (String method in methods) {
      String service = """package com.csttec.server.service.$packageName;

import org.springframework.stereotype.Service;

import com.csttec.server.core.AService;
import com.csttec.server.core.Bean;
import com.csttec.server.domain.Session;

/**
 * 설명.
 * 
 * <pre>

 * IN: NONE
 *  
 * OUT: NONE
 * 
 * </pre>
 * 
 * @author $author
 *
 */
@Service("$packageName.$method${table.domain}")
public class $method${table.domain}Service extends AService{

	@Override
	protected void doExecute(Bean input, Bean output) {
		Session session = (Session) input.get("session");
	}

}
      """;
      services.add(
          {"fileName": "$method${table.domain}Service", "service": service});
    }
    return services;
  }

  String getNullType(String type) {
    switch (type) {
      case "int":
      case "enum":
      case "boolean":
      case "double":
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

class Database {
  Future<List<Table>> loadDatabase(Location location, Schema schema) async {
    StringBuffer filePath = StringBuffer();

    switch (location) {
      case Location.local:
        filePath.write(SharedPreferences.prefs
                .getString(Preferences.localPersistencePath.name) ??
            '');
        break;
      case Location.svn:
        filePath.write(SharedPreferences.prefs
                .getString(Preferences.svnPersistencePath.name) ??
            '');
        break;
      default:
        break;
    }

    switch (schema) {
      case Schema.csttec:
        filePath.write('\\db-populate.sql');
        break;
      case Schema.center:
        filePath.write('\\center-db-populate.sql');
        break;
      default:
        break;
    }

    File sqlFile = File(filePath.toString());
    if (!await sqlFile.exists()) {
      return [];
    } else {
      Logger.i('database load from $filePath');
    }

    final sqlContents = await sqlFile.readAsString();

    String code = "";
    bool insert = false;
    List<Table> tableList = [];

    for (String sqlContent in sqlContents.split("\n")) {
      if (sqlContent.toUpperCase().startsWith("CREATE TABLE")) {
        insert = true;
      }

      if (insert) {
        code += "$sqlContent\n";
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

    return tableList;
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

    for (int i = 1; i < strings.length; i++) {
      final string = strings[i].trim();

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
        columns.add(Column(name, type, dbTypeToJavaType(type.toUpperCase()),
            isAI, isNullable));
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

String dbTypeToJavaType(type) {
  switch (type) {
    case "INT":
      return "int";
    case "DOUBLE":
      return "double";
    case "TINYINT":
      return "enum";
    case "TINYINT(1)":
    case "BOOL":
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
