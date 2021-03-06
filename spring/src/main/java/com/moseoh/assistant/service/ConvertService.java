package com.moseoh.assistant.service;

import com.moseoh.assistant.entity.MColumn;
import com.moseoh.assistant.entity.MTable;
import com.moseoh.assistant.utils.Utils;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ConvertService {

    private final TableService tableService;

    public String getDomain(Long mtableId) {
        MTable mTable = tableService.getTable(mtableId);

        StringBuilder sb = new StringBuilder();
        sb.append(getPackageAndImport(mTable));
        sb.append("public class ");
        sb.append(Utils.toCapitalize(mTable.getName()));
        sb.append(" {\n\n");

        for (MColumn column : mTable.getMcolumns()) {
            if (column.getType().equals("enum")) {
                sb.append(
                        "\tpublic enum ");
                sb.append(Utils.toCapitalize(column.getName()));
                sb.append(" {\n\n\t}\n\n");
            }
        }

        sb.append(getField(mTable));
        sb.append("\n");
        sb.append(getGetterSetter(mTable));
        sb.append("}");

        return sb.toString();
    }

    public String getMapper(Long mtableId) {
        MTable mTable = tableService.getTable(mtableId);
        StringBuilder sb = new StringBuilder();
        String format = null;

        format = "public void insert%1$s(@Param(\"siteName\") String siteName, @Param(\"value\") %1$s value);\n";
        sb.append(String.format(format, mTable.getName()));

        format = "public %1$s get%1$s(@Param(\"siteName\") String siteName, @Param(\"option\") %1$s option);\n";
        sb.append(String.format(format, mTable.getName()));

        format = "public List<%1$s> list%1$ss(@Param(\"siteName\") String siteName, @Param(\"option\") %1$s option);\n";
        sb.append(String.format(format, mTable.getName()));

        format = "public void update%1$s(@Param(\"siteName\") String siteName, @Param(\"value\") %1$s value);\n";
        sb.append(String.format(format, mTable.getName()));

        format = "public void delete%1$s(@Param(\"siteName\") String siteName, @Param(\"option\") %1$s option);";
        sb.append(String.format(format, mTable.getName()));

        return sb.toString();
    }

    public String getMybatis(Long mtableId) {
        MTable mTable = tableService.getTable(mtableId);
        StringBuilder sb = new StringBuilder();

        sb.append(getInsertQuery(mTable));
        sb.append("\n\n");
        sb.append(getSelectQuery(mTable));
        sb.append("\n\n");
        sb.append(getListQuery(mTable));
        sb.append("\n\n");
        sb.append(getUpdateQuery(mTable));
        sb.append("\n\n");
        sb.append(getDeleteQuery(mTable));

        return sb.toString();
    }

    private String getPackageAndImport(MTable mTable) {
        boolean hasBigDecimal = hasBigDecimal(mTable);
        boolean hasDate = hasDate(mTable);

        StringBuilder sb = new StringBuilder();
        sb.append("package com.csttec.server.domain;\n\n");
        if (hasBigDecimal) {
            sb.append("import java.math.BigDecimal;\n");
        }
        if (hasDate) {
            sb.append("import java.util.Date;\n");
        }
        if (hasBigDecimal || hasDate) {
            sb.append("\n");
        }
        return sb.toString();
    }

    private String getField(MTable mTable) {
        StringBuilder sb = new StringBuilder();
        for (MColumn mColumn : mTable.getMcolumns()) {
            sb.append("\tprivate ");
            sb.append(getFieldType(mColumn));
            sb.append(" ");
            sb.append(mColumn.getName());
            String defaultValue = getDefaultValue(mColumn);
            if (!defaultValue.equals("null")) {
                sb.append(" = ");
                sb.append(getDefaultValue(mColumn));
            }
            sb.append(";\n");
        }
        return sb.toString();
    }

    private String getGetterSetter(MTable mTable) {
        StringBuilder sb = new StringBuilder();
        for (MColumn mColumn : mTable.getMcolumns()) {
            switch (mColumn.getType()) {
                case "int":
                case "double":
                case "String":
                case "Date":
                    sb.append(getCommonMethod(mColumn));
                    break;
                case "enum":
                    sb.append(getEnumMethod(mColumn));
                    break;
                case "boolean":
                    sb.append(getBooleanMethod(mColumn));
                    break;
                case "BigDecimal":
                    sb.append(getBigDecimalMethod(mColumn));
                    break;
                default:
                    sb.append("UNKNOWN");
                    break;
            }
        }
        return sb.toString();
    }

    private String getFieldType(MColumn mColumn) {
        switch (mColumn.getType()) {
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
                return Utils.toCapitalize(mColumn.getName());
            default:
                return "UNKNOWN";
        }
    }

    private String getDefaultValue(MColumn mColumn) {
        switch (mColumn.getType()) {
            case "int":
            case "boolean":
            case "double":
                return "-1";
            case "enum":
            case "String":
            case "Date":
            case "BigDecimal":
            default:
                return "null";
        }
    }

    private String getCommonMethod(MColumn mColumn) {
        StringBuilder sb = new StringBuilder();
        String format = null;

        format = "\tpublic %1$s get%2$s() {\n\t\treturn %3$s;\n\t}\n\n";
        sb.append(String.format(format, mColumn.getType(), Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic void set%2$s(%1$s %3$s) {\n\t\tthis.%3$s = %3$s;\n\t}\n\n";
        sb.append(String.format(format, mColumn.getType(), Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        return sb.toString();
    }

    private String getEnumMethod(MColumn mColumn) {
        StringBuilder sb = new StringBuilder();
        String format = null;

        format = "\tpublic int get%1$s() {\n\t\treturn %2$s == null ? -1 : %2$s.ordinal();\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic %1$s %2$s() {\n\t\treturn %2$s;\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic void set%1$s(int %2$s) {\n\t\tthis.%2$s = %1$s.values()[%2$s];\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic void set%1$s(String %2$s) {\n\t\tthis.%2$s = %1$s.valueOf(%2$s);\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic void set%1$s(%1$s %2$s) {\n\t\tthis.%2$s = %2$s;\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        return sb.toString();
    }

    private String getBooleanMethod(MColumn mColumn) {
        StringBuilder sb = new StringBuilder();
        String format = null;

        format = "\tpublic int get%1$s() {\n\t\treturn %2$s;\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic boolean %2$s() {\n\t\treturn %2$s == 1;\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic void set%1$s(int %2$s) {\n\t\tthis.%2$s = %2$s;\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic void set%1$s(boolean %2$s) {\n\t\tthis.%2$s = %2$s ? 1 : 0;\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        return sb.toString();
    }

    private String getBigDecimalMethod(MColumn mColumn) {
        StringBuilder sb = new StringBuilder();
        String format = null;

        format = "\tpublic BigDecimal get%1$s() {\n\t\treturn %2$s;\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic void set%1$s(BigDecimal %2$s) {\n\t\tthis.%2$s = %2$s;\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic void set%1$s(long %2$s) {\n\t\tthis.%2$s = BigDecimal.valueOf(%2$s);\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        format = "\tpublic void set%1$s(double %2$s) {\n\t\tthis.%2$s = BigDecimal.valueOf(%2$s);\n\t}\n\n";
        sb.append(String.format(format, Utils.toCapitalize(mColumn.getName()), mColumn.getName()));

        return sb.toString();
    }

    private String getInsertQuery(MTable mTable) {
        StringBuilder sb = new StringBuilder();
        String format = null;

        if (hasAI(mTable)) {
            format = "<insert id=\"insert%1$s\" useGeneratedKeys=\"true\" keyProperty=\"value.id\">\n";
            sb.append(String.format(format, mTable.getName()));
        } else {
            format = "<insert id=\"insert%1$s\">\n";
            sb.append(String.format(format, mTable.getName()));
        }
        format = "\tinsert into ${siteName}.%1$s (\n";
        sb.append(String.format(format, mTable.getDbName()));
        sb.append("\t\t<trim suffixOverrides=\", \">\n");
        for (MColumn mColumn : mTable.getMcolumns()) {
            format = "\t\t\t<if test=\"value.%1$s != %2$s\">%3$s,</if>\n";
            sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn), mColumn.getDbName()));
        }
        sb.append("\t\t</trim>\n");
        sb.append("\t) values (\n");
        sb.append("\t\t<trim suffixOverrides=\",\">\n");
        for (MColumn mColumn : mTable.getMcolumns()) {
            format = "\t\t\t<if test=\"value.%1$s != %2$s\">#{value.%1$s},</if>\n";
            sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn)));
        }
        sb.append("\t\t</trim>\n");
        sb.append("\t)\n");
        sb.append("</insert>");
        return sb.toString();
    }

    private String getSelectQuery(MTable mTable) {
        StringBuilder sb = new StringBuilder();
        String format = null;

        format = "<select id=\"get%1$s\" resultType=\"%1$s\">\n";
        sb.append(String.format(format, mTable.getName()));
        sb.append("\tselect\n");

        for (int i = 0; i < mTable.getMcolumns().size(); i++) {
            format = "\t\t%1$s as \"%2$s\"";
            sb.append(String.format(format, mTable.getMcolumns().get(i).getDbName(),
                    mTable.getMcolumns().get(i).getName()));
            if (i != mTable.getMcolumns().size() - 1) {
                sb.append(",");
            }
            sb.append("\n");
        }
        sb.append("\tfrom\n");
        format = "\t\t${siteName}.%1$s\n";
        sb.append(String.format(format, mTable.getDbName()));
        sb.append("\t<where>\n");
        for (MColumn mColumn : mTable.getMcolumns()) {
            format = "\t\t<if test=\"option.%1$s != %2$s\">and %3$s = #{option.%1$s}</if>\n";
            sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn), mColumn.getDbName()));
        }
        sb.append("\t</where>\n");
        sb.append("</select>");
        return sb.toString();
    }

    private String getListQuery(MTable mTable) {
        StringBuilder sb = new StringBuilder();
        String format = null;

        format = "<select id=\"list%1$ss\" resultType=\"%1$s\">\n";
        sb.append(String.format(format, mTable.getName()));
        sb.append("\tselect\n");

        for (int i = 0; i < mTable.getMcolumns().size(); i++) {
            format = "\t\t%1$s as \"%2$s\"";
            sb.append(String.format(format, mTable.getMcolumns().get(i).getDbName(),
                    mTable.getMcolumns().get(i).getName()));
            if (i != mTable.getMcolumns().size() - 1) {
                sb.append(",");
            }
            sb.append("\n");
        }
        sb.append("\tfrom\n");
        format = "\t\t${siteName}.%1$s\n";
        sb.append(String.format(format, mTable.getDbName()));
        sb.append("\t<where>\n");
        for (MColumn mColumn : mTable.getMcolumns()) {
            format = "\t\t<if test=\"option.%1$s != %2$s\">and %3$s = #{option.%1$s}</if>\n";
            sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn), mColumn.getDbName()));
        }
        sb.append("\t</where>\n");
        sb.append("</select>");
        return sb.toString();
    }

    private String getUpdateQuery(MTable mTable) {
        StringBuilder sb = new StringBuilder();
        String format = null;

        format = "<update id=\"update%1$s\">\n";
        sb.append(String.format(format, mTable.getName()));
        format = "\tupdate ${siteName}.%1$s\n";
        sb.append(String.format(format, mTable.getDbName()));
        sb.append("\t<set>\n");
        for (MColumn mColumn : mTable.getMcolumns()) {
            if (mColumn.getName().equals("id"))
                continue;
            format = "\t\t<if test=\"value.%1$s != %2$s\">%3$s = #{value.%1$s},</if>\n";
            sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn), mColumn.getDbName()));
        }
        sb.append("\t</set>\n");

        sb.append("\t<where>\n");
        if (hasPk(mTable)) {
            for (MColumn mColumn : mTable.getMcolumns()) {
                if (!mColumn.isPk()) {
                    continue;
                }
                format = "\t\t<if test=\"value.%1$s != %2$s\">and %3$s = #{value.%1$s}</if>\n";
                sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn), mColumn.getDbName()));
            }
        } else if (hasFk(mTable)) {
            for (MColumn mColumn : mTable.getMcolumns()) {
                if (!mColumn.isFk()) {
                    continue;
                }
                format = "\t\t<if test=\"value.%1$s != %2$s\">and %3$s = #{value.%1$s}</if>\n";
                sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn), mColumn.getDbName()));
            }
        } else {
            for (MColumn mColumn : mTable.getMcolumns()) {
                format = "\t\t<if test=\"value.%1$s != %2$s\">and %3$s = #{value.%1$s}</if>\n";
                sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn), mColumn.getDbName()));
            }
        }
        sb.append("\t</where>\n");

        sb.append("</update>");

        return sb.toString();
    }

    private String getDeleteQuery(MTable mTable) {
        StringBuilder sb = new StringBuilder();
        String format = null;

        format = "<delete id=\"delete%1$s\">\n";
        sb.append(String.format(format, mTable.getName()));
        format = "\tdelete from\n\t\t${siteName}.%1$s\n";
        sb.append(String.format(format, mTable.getDbName()));
        sb.append("\t<where>\n");
        if (hasPk(mTable)) {
            for (MColumn mColumn : mTable.getMcolumns()) {
                if (!mColumn.isPk()) {
                    continue;
                }
                format = "\t\t<if test=\"value.%1$s != %2$s\">and %3$s = #{value.%1$s}</if>\n";
                sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn), mColumn.getDbName()));
            }
        } else if (hasFk(mTable)) {
            for (MColumn mColumn : mTable.getMcolumns()) {
                if (!mColumn.isFk()) {
                    continue;
                }
                format = "\t\t<if test=\"value.%1$s != %2$s\">and %3$s = #{value.%1$s}</if>\n";
                sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn), mColumn.getDbName()));
            }
        } else {
            for (MColumn mColumn : mTable.getMcolumns()) {
                format = "\t\t<if test=\"value.%1$s != %2$s\">and %3$s = #{value.%1$s}</if>\n";
                sb.append(String.format(format, mColumn.getName(), getDefaultValue(mColumn), mColumn.getDbName()));
            }
        }
        sb.append("\t</where>\n");
        sb.append("</delete>");

        return sb.toString();
    }

    private boolean hasPk(MTable mTable) {
        for (MColumn mColumn : mTable.getMcolumns()) {
            if (mColumn.isPk()) {
                return true;
            }
        }
        return false;
    }

    private boolean hasFk(MTable mTable) {
        for (MColumn mColumn : mTable.getMcolumns()) {
            if (mColumn.isFk()) {
                return true;
            }
        }
        return false;
    }

    private boolean hasAI(MTable mTable) {
        for (MColumn mColumn : mTable.getMcolumns()) {
            if (mColumn.isAi()) {
                return true;
            }
        }
        return false;
    }

    private boolean hasBigDecimal(MTable mTable) {
        for (MColumn column : mTable.getMcolumns()) {
            if (column.getType().equals("BigDecimal")) {
                return true;
            }
        }
        return false;
    }

    private boolean hasDate(MTable mTable) {
        for (MColumn column : mTable.getMcolumns()) {
            if (column.getType().equals("Date")) {
                return true;
            }
        }
        return false;
    }
}
