package com.moseoh.assistant.client.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.moseoh.assistant.controller.auth.dto.SignInResponseDto;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LoginResponseDto extends BaseResponseDto {
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

    public SignInResponseDto toSignInResponseDto() {
        return new SignInResponseDto(
                userId,
                sessionId,
                siteName,
                userEmail,
                userName,
                metaServerUrl,
                fileServerUrl,
                userPictureUrl
        );
    }
}
