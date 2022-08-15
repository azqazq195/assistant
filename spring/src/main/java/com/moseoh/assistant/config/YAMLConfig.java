package com.moseoh.assistant.utils.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class YAMLConfig {
    @Value("${gitToken}")
    private String token;
    @Value("${spring.svn.url}")
    private String svnUrl;
    @Value("${spring.svn.username}")
    private String svnUsername;
    @Value("${spring.svn.password}")
    private String svnPassword;
}
