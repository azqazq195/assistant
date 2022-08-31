package com.moseoh.assistant.controller.auth.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SignInResponseDto {
    private int id;
    private String sessionId;
    private String siteName;
    private String email;
    private String name;
    private String metaServerUrl;
    private String fileServerUrl;
    private String profileUrl;
}
