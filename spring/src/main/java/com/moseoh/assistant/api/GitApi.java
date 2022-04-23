package com.moseoh.assistant.api;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class GitApi {
    @Value("${gitToken}")
    private String token;
}
