package com.moseoh.assistant.csttec.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.moseoh.assistant.auth.entity.User;
import com.moseoh.assistant.csttec.dto.base.BaseResponseDto;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Collections;

@Getter
@AllArgsConstructor
public class LoginResponse extends BaseResponseDto {
    @JsonProperty(value = "user_id")
    private int userId;
    @JsonProperty(value = "user_email")
    private String userEmail;
    @JsonProperty(value = "user_name")
    private String userName;
    @JsonProperty(value = "session_id")
    private String sessionId;
    @JsonProperty(value = "site_name")
    private String siteName;
    @JsonProperty(value = "meta_server_url")
    private String metaServerUrl;
    @JsonProperty(value = "file_server_url")
    private String fileServerUrl;
    @JsonProperty(value = "user_picture")
    private String userPictureUrl;

    public User toUser() {
        return User.builder()
                .userId(userId)
                .userEmail(userEmail)
                .userName(userName)
                .sessionId(sessionId)
                .siteName(siteName)
                .metaServerUrl(metaServerUrl)
                .fileServerUrl(fileServerUrl)
                .userPictureUrl(userPictureUrl)
                .roles(Collections.singletonList("ROLE_USER"))
                .build();
    }
}
