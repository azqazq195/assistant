package com.moseoh.assistant.controller;

import com.moseoh.assistant.response.ErrorResponse;
import com.moseoh.assistant.utils.exception.ServiceException.ErrorCode;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("exception")
public class ExceptionController {

    @GetMapping("/entrypoint")
    public ResponseEntity<ErrorResponse> entrypoint() {
        return ErrorResponse.toResponseEntity(ErrorCode.HAVE_NOT_ACCESS);
    }

    @GetMapping("/accessDenied")
    public ResponseEntity<ErrorResponse> accessDenied() {
        return ErrorResponse.toResponseEntity(ErrorCode.UNAUTHORIZED);
    }
}
