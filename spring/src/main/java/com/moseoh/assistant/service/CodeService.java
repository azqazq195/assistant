package com.moseoh.assistant.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import com.moseoh.assistant.dto.ReloadReqeustDto;
import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.utils.exception.ServiceException;
import com.moseoh.assistant.utils.exception.ServiceException.ErrorCode;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CodeService {

    private final SvnService svnService;
    private final TableService tableService;
    private final UserService userService;

    public String reload(ReloadReqeustDto reloadReqeustDto) {
        // updateSvnTables(userService.getSvnUser());
        updateUserTables(userService.getRequestedUser(), reloadReqeustDto);
        return "";
    }

    protected void updateSvnTables(User adminUser) {
        if (!svnService.export()) {
            throw new ServiceException(ErrorCode.CANNOT_CHECKOUT_SVN);
        }

        deleteTables(adminUser);
        createSvnTables(adminUser);
    }

    protected void updateUserTables(User user, ReloadReqeustDto reloadReqeustDto) {
        deleteTables(user);
        createUserTables(user, reloadReqeustDto);
    }

    protected void createSvnTables(User adminUser) {
        File[] files = new File[] { new File("db-populate.sql"), new File("center-db-populate.sql") };
        try {
            for (File file : files) {
                String sqlContents = Files.readString(file.toPath());
                tableService.createTables(adminUser, sqlContents);
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw new ServiceException(ErrorCode.ERROR);
        }
    }

    protected void createUserTables(User user, ReloadReqeustDto reloadReqeustDto) {
        if (reloadReqeustDto.getCenterDbPopulate() != null) {
            tableService.createTables(user, reloadReqeustDto.getCenterDbPopulate());
        }
        if (reloadReqeustDto.getDbPopulate() != null) {
            tableService.createTables(user, reloadReqeustDto.getDbPopulate());
        }
    }

    protected void deleteTables(User user) {
        tableService.deleteTables(user);
    }
}
