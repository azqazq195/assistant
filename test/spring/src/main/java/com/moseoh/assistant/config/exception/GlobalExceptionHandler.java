package com.moseoh.assistant.config.exception;

import com.moseoh.assistant.response.ErrorCode;
import com.moseoh.assistant.response.Response;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {


    @ExceptionHandler(ApiException.class)
    public ResponseEntity<Response<Object>> handleApiException(ApiException e) {
        log.info("api exception", e);
        return errorResponse(e.getErrorCode(), e.getMessage());
    }

    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Response<Object>> handleException(Exception e) {
        log.info("unhandled exception", e);
        return errorResponse();
    }

    private ResponseEntity<Response<Object>> errorResponse() {
        return errorResponse(ErrorCode.INTERNAL_SERVER_ERROR, null);
    }

    private ResponseEntity<Response<Object>> errorResponse(ErrorCode errorCode, String message) {
        return ResponseEntity.status(errorCode.getHttpStatus())
                .body(
                        new Response<>(
                                errorCode,
                                message == null ? errorCode.getMessage() : message,
                                null
                        )
                );
    }
}