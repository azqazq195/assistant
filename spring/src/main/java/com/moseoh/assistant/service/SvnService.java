package com.moseoh.assistant.service;

import com.moseoh.assistant.config.YAMLConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

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
        File[] files = new File[]{new File("db-populate.sql"), new File("center-db-populate.sql")};
        for (File file : files) {
            if (file.exists()) {
                file.delete();
            }
        }

        log.info("export files from svn");
        for (String command : commandList) {
            Process process = null;
            BufferedReader br = null;
            try {
                process = Runtime.getRuntime().exec(command, null, new File("/"));

                // 실행 결과 확인 (에러) 
                br = new BufferedReader(new InputStreamReader(process.getErrorStream(), "EUC-KR"));
                log.info("\n ## ERROR : ");
                String line = null;
                while ((line = br.readLine()) != null) {
                    log.info(line);
                }
                br = null;

                // 실행 결과 확인
                br = new BufferedReader(new InputStreamReader(process.getInputStream()));
                log.info("\n ## RESULT:");
                line = null;
                while ((line = br.readLine()) != null) {
                    log.info(line);
                }

                process.waitFor();
            } catch (IOException | InterruptedException e) {
                e.printStackTrace();
            } finally {
                process.destroy();
            }
        }
        return true;
    }
}
