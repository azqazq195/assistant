package com.moseoh.assistant.response;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@JsonInclude(Include.NON_NULL)
public class Response {
    private final LocalDateTime timestamp;
    private final int status;
    private final String message;
    private final Object data;

    public static ResponseEntity<Response> toResponseEntity(Object object) {
        HttpStatus httpStatus = HttpStatus.OK;

        if (object == null) {
            return ResponseEntity.status(httpStatus)
                    .body(Response.builder()
                            .timestamp(LocalDateTime.now())
                            .status(httpStatus.value())
                            .message(httpStatus.name())
                            .build());
        } else {
            return ResponseEntity.status(httpStatus)
                    .body(Response.builder()
                            .timestamp(LocalDateTime.now())
                            .status(httpStatus.value())
                            .message(httpStatus.name())
                            .data(object)
                            .build());
        }
    }
}
