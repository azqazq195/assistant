package com.moseoh.assistant.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Response<T> {
    private int status;
    private String message;
    private T data;

    public Response(SuccessCode successCode, T data) {
        this.status = successCode.getHttpStatus().value();
        this.message = successCode.getMessage();
        this.data = data;
    }
}
