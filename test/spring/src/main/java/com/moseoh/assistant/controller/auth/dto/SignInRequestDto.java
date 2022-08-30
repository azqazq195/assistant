package com.moseoh.assistant.controller.auth.dto;

import com.moseoh.assistant.client.dto.LoginRequestDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SignInRequestDto {
    @NotBlank
    private String email;
    @NotBlank
    private String password;
    @NotBlank
    private String ip;

    public LoginRequestDto toLoginRequestDto() {
        return new LoginRequestDto(
                email,
                password,
                ip
        );
    }
}
