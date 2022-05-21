package com.moseoh.assistant.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import com.moseoh.assistant.dto.DomainDto;
import com.moseoh.assistant.dto.TableResponseDto;
import com.moseoh.assistant.entity.MColumn;
import com.moseoh.assistant.entity.MTable;
import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.repository.TableRepository;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TableService {

    private final TableRepository tableRepository;

    private final ColumnService columnService;
    private final UserService userService;

    private final String[] DATABASE_NAMES = { "csttec", "center" };

    public String getDomainData(Long mtableId) {
        MTable table = tableRepository.getById(mtableId);
        StringBuilder sb = new StringBuilder();
        return "result";
    }

    public TableResponseDto getTable(String databaseName, String tableName) {
        User adminUser = userService.getSvnUser();
        User user = userService.getRequestedUser();

        MTable adminTable = tableRepository.findByNameAndDatabaseNameAndUserId(tableName, databaseName,
                adminUser.getId());
        if (adminTable != null) {
            adminTable.setMcolumns(columnService.getColumns(adminTable.getId()));
        }
        MTable userTable = tableRepository.findByNameAndDatabaseNameAndUserId(tableName, databaseName, user.getId());
        userTable.setMcolumns(columnService.getColumns(userTable.getId()));

        return new TableResponseDto(adminTable, userTable);
    }

    public List<String> getTableNames(String databaseName) {
        User user = userService.getRequestedUser();
        User adminUser = userService.getSvnUser();
        List<Long> userIds = new ArrayList<>();
        userIds.add(user.getId());
        userIds.add(adminUser.getId());

        List<MTable> tables = tableRepository.findDistinctNameByDatabaseNameAndUserIdIn(databaseName, userIds);
        Set<String> tableNames = new TreeSet<>();
        for (MTable table : tables) {
            tableNames.add(table.getName());
        }
        return new ArrayList<>(tableNames);
    }

    public List<MTable> createTables(User user, String sqlContents) {
        boolean insert = false;
        StringBuilder code = new StringBuilder();
        List<MTable> tables = new ArrayList<>();

        for (String sqlContent : sqlContents.split("\n")) {
            if (sqlContent.toUpperCase().startsWith("CREATE TABLE")) {
                insert = true;
            }
            if (insert) {
                code.append(sqlContent);
                code.append("\n");
            }
            if (sqlContent.contains(";")) {
                if (code.length() == 0) {
                    continue;
                }
                tables.add(createTable(code.toString()));
                code.setLength(0);
                insert = false;
            }
        }

        for (MTable table : tables) {
            table.setUser(user);
            save(table);
            for (MColumn column : table.getMcolumns()) {
                column.setMtable(table);
                columnService.save(column);
            }
        }

        return tables;
    }

    public void save(MTable table) {
        MTable currentTable = tableRepository.findByNameAndDatabaseNameAndUserId(table.getName(),
                table.getDatabaseName(), table.getUser().getId());
        if (currentTable != null) {
            table.setId(currentTable.getId());
        }
        tableRepository.save(table);

    }

    public void deleteTables(User user) {
        for (String databaseName : DATABASE_NAMES) {
            tableRepository.deleteAllByUserIdAndDatabaseName(user.getId(), databaseName);
        }
    }

    private MTable createTable(String code) {
        String[] strs = code.split("\n");

        /*
         * database, table name 구하기
         */
        String temp = strs[0].trim();
        temp = temp.substring(0, temp.lastIndexOf("`"));
        String tableName = temp.substring(temp.lastIndexOf("`") + 2);
        temp = temp.substring(0, temp.lastIndexOf("`"));
        String databaseName = temp.substring(temp.indexOf("`") + 1, temp.lastIndexOf("`"));
        String domain = toCapitalize(toCamel(tableName));

        MTable mTable = new MTable();
        mTable.setName(domain);
        mTable.setDatabaseName(databaseName);

        for (int i = 1; i < strs.length; i++) {
            String str = strs[i].trim();

            if (str.startsWith("`")) {
                mTable.addMColumn(getColumn(str));
            }

            if (str.indexOf("PRIMARY KEY") == 0) {
                setPk(mTable.getMcolumns(), str);
            }

            if (str.indexOf("FOREIGN KEY") == 0) {
                setFk(mTable.getMcolumns(), str);
            }
        }

        setNameDbToDomain(mTable.getMcolumns());

        return mTable;
    }

    private void setNameDbToDomain(List<MColumn> columns) {
        for (MColumn column : columns) {
            String name = toCamel(column.getName());
            if (!column.isPk() && !column.isFk() && name.startsWith("c")) {
                name = name.substring(1);
            }
            column.setName(name);
        }
    }

    private MColumn getColumn(String str) {
        return MColumn.builder()
                .ai(isAi(str))
                .nullable(isNullable(str))
                .name(getColumnName(str))
                .type(getColumnType(str))
                .build();
    }

    private void setFk(List<MColumn> columns, String str) {
        String temp = str.substring(str.indexOf("(") + 1, str.lastIndexOf(")"));
        String[] fks = temp.split(", ");

        for (String fk : fks) {
            fk = fk.substring(fk.indexOf("`") + 1, fk.lastIndexOf("`"));
            for (MColumn column : columns) {
                if (column.getName().equals(fk)) {
                    column.setFk(true);
                }
            }
        }
    }

    private void setPk(List<MColumn> columns, String str) {
        String temp = str.substring(str.indexOf("(") + 1, str.lastIndexOf(")"));
        String[] pks = temp.split(", ");

        for (String pk : pks) {
            pk = pk.substring(pk.indexOf("`") + 1, pk.lastIndexOf("`"));
            for (MColumn column : columns) {
                if (column.getName().equals(pk)) {
                    column.setPk(true);
                }
            }
        }
    }

    private String getColumnName(String str) {
        String[] temp = str.split(" ");
        return temp[0]
                .substring(temp[0].indexOf("`") + 1, temp[0].lastIndexOf("`"));
    }

    private String getColumnType(String str) {
        String[] temp = str.split(" ");
        String type = temp[1].toUpperCase();
        if (!type.contains("TINYINT")) {
            type = type.replaceAll("[^A-Z]", "");
        }

        if (type.contains("INT")) {
            return "int";
        } else if (type.contains("SMALLINT")) {
            return "int";
        } else if (type.contains("DOUBLE")) {
            return "double";
        } else if (type.contains("TINYINT")) {
            return "enum";
        } else if (type.contains("TINYINT(1)")) {
            return "boolean";
        } else if (type.contains("BOOL")) {
            return "boolean";
        } else if (type.contains("VARCHAR")) {
            return "String";
        } else if (type.contains("TEXT")) {
            return "String";
        } else if (type.contains("DECIMAL")) {
            return "BigDecimal";
        } else if (type.contains("TIMESTAMP")) {
            return "Date";
        } else {
            return "UNKNOWNTYPE_PLEASE_REQUEST_BUG_REPORT";
        }
    }

    private boolean isAi(String str) {
        if (str.contains("AUTO_INCREMENT")) {
            return true;
        } else {
            return false;
        }
    }

    private boolean isNullable(String str) {
        if (str.contains("NOT NULL")) {
            return false;
        } else {
            return true;
        }
    }

    private String toCapitalize(String str) {
        return Character.toUpperCase(str.charAt(0)) + str.substring(1);
    }

    private String toCamel(String str) {
        var result = "";
        var temp = str.split("_");
        for (int k = 0; k < temp.length; k++) {
            if (k == 0) {
                result += temp[k];
            } else {
                result += Character.toUpperCase(temp[k].charAt(0)) + temp[k].substring(1);
            }
        }
        return result;
    }
}
