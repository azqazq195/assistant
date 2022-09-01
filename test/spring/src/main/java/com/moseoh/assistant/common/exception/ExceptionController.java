package com.moseoh.assistant.common.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class ExceptionController {

    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<ExceptionDto> badRequestExceptionHandler(BadRequestException e) {
        log.warn(e.getMessage());
        return ResponseEntity.badRequest()
                .body(new ExceptionDto(e.getCode(), e.getMessage()));
    }

}
