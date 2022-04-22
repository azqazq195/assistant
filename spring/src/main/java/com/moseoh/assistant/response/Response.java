package com.moseoh.assistant.response;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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

    private final LocalDateTime timestamp = LocalDateTime.now();
    private final int status;
    private final int code;
    private final String message;
    private final List<Object> data;

    @SuppressWarnings("unchecked")
    public static ResponseEntity<Response> toResponseEntity(Object object) {
        List<Object> data;
        HttpStatus httpStatus = HttpStatus.OK;

        if (object instanceof List) {
            data = (List<Object>) object;
        } else {
            data = new ArrayList<>();
            data.add(object);
        }

        // if (data.isEmpty()) {
        // httpStatus = HttpStatus.NO_CONTENT;
        // } else {
        // httpStatus = HttpStatus.OK;
        // }

        if (data.isEmpty()) {
            return ResponseEntity.status(httpStatus)
                    .body(Response.builder().status(httpStatus.value()).code(httpStatus.value())
                            .message(httpStatus.name())
                            .build());
        } else {
            return ResponseEntity.status(httpStatus)
                    .body(Response.builder().status(httpStatus.value()).code(httpStatus.value())
                            .message(httpStatus.name())
                            .data(data)
                            .build());
        }

        // return ResponseEntity.status(httpStatus)
        // .body(Response.builder().status(httpStatus.value()).code(httpStatus.value())
        // .message(httpStatus.name())
        // .data(data)
        // .build());
    }
}
