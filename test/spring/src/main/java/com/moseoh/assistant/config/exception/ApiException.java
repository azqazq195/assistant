package com.moseoh.assistant.config.exception;

import com.moseoh.assistant.response.ErrorCode;
import lombok.Getter;

@Getter
public class ApiException extends RuntimeException {
    private final ErrorCode errorCode;
    private String message;

    public ApiException(ErrorCode errorCode) {
        this.errorCode = errorCode;
    }

    public ApiException(ErrorCode errorCode, String message) {
        this.errorCode = errorCode;
        this.message = message;
    }
}
