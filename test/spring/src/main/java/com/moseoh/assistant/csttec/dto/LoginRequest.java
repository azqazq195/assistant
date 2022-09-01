package com.moseoh.assistant.csttec.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.moseoh.assistant.csttec.dto.base.BaseRequestDto;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class LoginRequest extends BaseRequestDto {
    @JsonProperty(value = "email")
    private String email;
    @JsonProperty(value = "password")
    private String password;
    @JsonProperty(value = "ip")
    private String ip;
}