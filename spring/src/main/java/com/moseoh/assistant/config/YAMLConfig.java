package com.moseoh.assistant.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

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
