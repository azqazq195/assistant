package com.moseoh.assistant.client.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LoginRequestDto {
    private final String service = "common.Login";
    private String email;
    private String password;
    private String ip;
}
