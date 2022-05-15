package com.moseoh.assistant.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.moseoh.assistant.utils.config.YAMLConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        for (String command : commandList) {
            try {
                Runtime.getRuntime().exec(command);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return true;
    }
}
