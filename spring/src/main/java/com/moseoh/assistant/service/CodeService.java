package com.moseoh.assistant.service;

import com.moseoh.assistant.dto.ReloadRequestDto;
import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.utils.exception.ServiceException;
import com.moseoh.assistant.utils.exception.ServiceException.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@Service
@RequiredArgsConstructor
public class CodeService {

    private final SvnService svnService;
    private final TableService tableService;
    private final UserService userService;

    public String reload(ReloadRequestDto reloadRequestDto) {
        // updateSvnTables(userService.getSvnUser());
        updateUserTables(userService.getRequestedUser(), reloadRequestDto);
        return "";
    }

    protected void updateSvnTables(User adminUser) {
        if (!svnService.export()) {
            throw new ServiceException(ErrorCode.CANNOT_CHECKOUT_SVN);
        }

        deleteTables(adminUser);
        createSvnTables(adminUser);
    }

    protected void updateUserTables(User user, ReloadRequestDto reloadRequestDto) {
        deleteTables(user);
        createUserTables(user, reloadRequestDto);
    }

    protected void createSvnTables(User adminUser) {
        File[] files = new File[]{new File("db-populate.sql"), new File("center-db-populate.sql")};
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

    protected void createUserTables(User user, ReloadRequestDto reloadRequestDto) {
        if (reloadRequestDto.getCenterDbPopulate() != null) {
            tableService.createTables(user, reloadRequestDto.getCenterDbPopulate());
        }
        if (reloadRequestDto.getDbPopulate() != null) {
            tableService.createTables(user, reloadRequestDto.getDbPopulate());
        }
    }

    protected void deleteTables(User user) {
        tableService.deleteTables(user);
    }
}
