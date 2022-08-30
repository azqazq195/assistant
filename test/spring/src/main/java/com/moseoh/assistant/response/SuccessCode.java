package com.moseoh.assistant.response;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum SuccessCode {
    SIGN_UP(HttpStatus.OK, "회원 가입"),
    SIGN_IN(HttpStatus.OK, "로그인"),
    ME(HttpStatus.OK, "내정보"),
    SCRAP(HttpStatus.OK, "동기스크랩"),
    REFUND(HttpStatus.OK, "환급액"),
    ;


    private final HttpStatus httpStatus;
    private final String message;
}
