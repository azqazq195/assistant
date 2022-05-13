package com.moseoh.assistant.dto;

import com.moseoh.assistant.utils.exception.ServiceException;
import com.moseoh.assistant.utils.exception.ServiceException.ErrorCode;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SignInRequestDto {
    private String email;
    private String password;

    public void checkEmpty() {
        if (email.isEmpty()) {
            throw new ServiceException(ErrorCode.EMPTY_EMAIL);
        }
        if (password.isEmpty()) {
            throw new ServiceException(ErrorCode.EMPTY_PASSWORD);
        }
    }
}
