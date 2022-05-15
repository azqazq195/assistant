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
        updateSvnTables();
        updateUserTables(reloadReqeustDto);
        return "";
    }

    protected void updateSvnTables() {
        User adminUser = userService.getSvnUser();

        if (!svnService.export()) {
            throw new ServiceException(ErrorCode.CANNOT_CHECKOUT_SVN);
        }

        File[] files = new File[] { new File("db-populate.sql"), new File("center-db-populate.sql") };

        try {
            for (File file : files) {
                String sqlContents = Files.readString(file.toPath());
                tableService.createTables(adminUser, sqlContents);
            }
        } catch (IOException e) {
            throw new ServiceException(ErrorCode.ERROR);
        }
    }

    private void updateUserTables(ReloadReqeustDto reloadReqeustDto) {
        User user = userService.getRequestedUser();

        tableService.createTables(user, reloadReqeustDto.getDbPopulate());
        tableService.createTables(user, reloadReqeustDto.getCenterDbPopulate());
    }
}
