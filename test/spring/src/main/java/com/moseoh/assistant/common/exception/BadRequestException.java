package com.moseoh.assistant.common.exception;

import lombok.Getter;

@Getter
public class BadRequestException extends RuntimeException {

    private final String message;
    private final String code;

    public BadRequestException() {
        BadRequestCode codeAndMessage = BadRequestCode.findByClass(this.getClass());
        this.message = codeAndMessage.getMessage();
        this.code = codeAndMessage.getCode();
    }
}