package com.moseoh.assistant.dto;

import java.util.Collections;

import com.moseoh.assistant.entity.User;
import com.moseoh.assistant.utils.exception.ServiceException;
import com.moseoh.assistant.utils.exception.ServiceException.ErrorCode;

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

    public void checkEmpty() {
        if (username.isEmpty()) {
            throw new ServiceException(ErrorCode.EMPTY_USERNAME);
        }
        if (email.isEmpty()) {
            throw new ServiceException(ErrorCode.EMPTY_EMAIL);
        }
        if (password.isEmpty()) {
            throw new ServiceException(ErrorCode.EMPTY_PASSWORD);
        }
        if (passwordCheck.isEmpty()) {
            throw new ServiceException(ErrorCode.EMPTY_PASSWORD_CHECK);
        }
    }
}
