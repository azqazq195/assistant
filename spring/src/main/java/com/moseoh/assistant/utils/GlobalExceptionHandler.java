package com.moseoh.assistant.utils;

import com.moseoh.assistant.response.ErrorResponse;
import com.moseoh.assistant.utils.ServiceException.ErrorCode;

import org.hibernate.exception.ConstraintViolationException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler(value = { ConstraintViolationException.class, DataIntegrityViolationException.class })
    protected ResponseEntity<ErrorResponse> handleDataException() {
        log.error("handleDataException thorw Exception", ErrorCode.DUPLICATE_RESOURCE);
        return ErrorResponse.toResponseEntity(ErrorCode.DUPLICATE_RESOURCE);
    }

    @ExceptionHandler(value = { ServiceException.class })
    protected ResponseEntity<ErrorResponse> handleCustomException(ServiceException e) {
        log.error("handleServiceException throw ServiceException : {}", e.getErrorCode());
        return ErrorResponse.toResponseEntity(e.getErrorCode());
    }
}
