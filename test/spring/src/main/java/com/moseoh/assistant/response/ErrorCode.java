package com.moseoh.assistant.response;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {
    BAD_REQUEST(HttpStatus.BAD_REQUEST, "잘못된 요청입니다."),
    MISSING_PARAMETER(HttpStatus.BAD_REQUEST, "요청 파라미터를 확인해 주세요."),
    EXIST_USERID(HttpStatus.BAD_REQUEST, "이미 존재하는 아이디 입니다."),
    EXIST_REG_NO(HttpStatus.BAD_REQUEST, "이미 존재하는 주민등록번호 입니다."),
    INVALID_VALUE(HttpStatus.BAD_REQUEST, "유효하지 않은 값입니다."),
    INCORRECT_PASSWORD(HttpStatus.BAD_REQUEST, "잘못된 패스워드 입니다."),
    UNREGISTERED_USER(HttpStatus.BAD_REQUEST, "등록할 수 없는 사용자 입니다."),
    CAN_NOT_REFUND(HttpStatus.BAD_REQUEST, "요청하신 값은 환급 조회 가능유저가 아닙니다."),
    TOTAL_SALARY_NOT_FOUND(HttpStatus.BAD_REQUEST, "총급여액 값을 찾을 수 없습니다."),
    TAX_AMOUNT_NOT_FOUND(HttpStatus.BAD_REQUEST, "산출세액 값을 찾을 수 없습니다."),

    INVALID_TOKEN(HttpStatus.UNAUTHORIZED, "유효하지 않은 토큰입니다."),
    INVALID_AUTHORIZED(HttpStatus.UNAUTHORIZED, "유효하지 않은 사용자 입니다."),

    TOKEN_NOT_FOUND(HttpStatus.NOT_FOUND, "존재하지 않는 토큰 입니다."),
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "존재하지 않는 사용자 입니다."),
    RESOURCE_NOT_FOUND(HttpStatus.NOT_FOUND, "존재하지 않는 데이터 입니다."),


    FAIL_TO_LOAD_SCRAP(HttpStatus.INTERNAL_SERVER_ERROR, "스크랩을 불러오는 중 오류가 발생했습니다."),
    INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "내부 서버 오류 발생."),
    ;

    private final HttpStatus httpStatus;
    private final String message;
}
