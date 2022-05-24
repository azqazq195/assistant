package com.moseoh.assistant.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.moseoh.assistant.utils.config.YAMLConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SvnService {
    private List<String> commandList;

    @Autowired
    public SvnService(YAMLConfig yamlConfig) {
        this.commandList = new ArrayList<>();

        StringBuilder prefix = new StringBuilder();
        prefix.append("svn export ");
        prefix.append(yamlConfig.getSvnUrl());

        StringBuilder suffix = new StringBuilder();
        suffix.append(" --username ");
        suffix.append(yamlConfig.getSvnUsername());
        suffix.append(" --password ");
        suffix.append(yamlConfig.getSvnPassword());

        this.commandList.add(prefix.toString() + "db-populate.sql" + suffix.toString());
        this.commandList.add(prefix.toString() + "center-db-populate.sql" + suffix.toString());
    }

    public boolean export() {
        log.info("delete old files, before export.");
        File[] files = new File[] { new File("db-populate.sql"), new File("center-db-populate.sql") };
        for (File file : files) {
            if (file.exists()) {
                file.delete();
            }
        }

        log.info("export files from svn");
        for (String command : commandList) {
            try {
                Process process = Runtime.getRuntime().exec(command);
                process.destroy();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        log.info(files[0].getAbsolutePath());
        return true;
    }
}
