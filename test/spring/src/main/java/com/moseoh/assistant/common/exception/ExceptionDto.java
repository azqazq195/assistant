package com.moseoh.assistant.common.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ExceptionDto {
    private String code;
    private String message;
}