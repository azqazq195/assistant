package com.moseoh.assistant.controller.auth.dto;

import com.moseoh.assistant.client.dto.LoginRequestRequestDto;
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

    public LoginRequestRequestDto toLoginRequestDto() {
        return new LoginRequestRequestDto(
                email,
                password,
                ip
        );
    }
}
