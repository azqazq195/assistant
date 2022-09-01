package com.moseoh.assistant.auth.application.dto;

import com.moseoh.assistant.csttec.dto.LoginRequest;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SignInRequest {
    @NotBlank
    private String email;
    @NotBlank
    private String password;
    @NotBlank
    private String ip;

    public LoginRequest toLoginRequestDto() {
        return new LoginRequest(
                email,
                password,
                ip
        );
    }
}
