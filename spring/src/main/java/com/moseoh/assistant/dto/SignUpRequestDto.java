package com.moseoh.assistant.dto;

import java.util.Collections;

import com.moseoh.assistant.entity.User;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SignUpRequestDto {
    private String username;
    private String email;
    private String password;
    private String passwordCheck;

    public User toEntity() {
        return User.builder()
                .username(username)
                .email(email)
                .password(password)
                .roles(Collections.singletonList("ROLE_USER"))
                .build();
    }
}
