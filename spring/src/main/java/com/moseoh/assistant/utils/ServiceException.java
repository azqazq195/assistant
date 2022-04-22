package com.moseoh.assistant.utils;

import org.springframework.http.HttpStatus;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ServiceException extends RuntimeException {
    private final ErrorCode errorCode;

    @Getter
    @AllArgsConstructor
    public enum ErrorCode {

        /* 400 BAD_REQUEST : 잘못된 요청 */
        INVALID_REFRESH_TOKEN(HttpStatus.BAD_REQUEST, "리프레시 토큰이 유효하지 않습니다."),
        MISMATCH_REFRESH_TOKEN(HttpStatus.BAD_REQUEST, "리프레시 토큰의 유저 정보가 일치하지 않습니다."),
        CANNOT_FOLLOW_MYSELF(HttpStatus.BAD_REQUEST, "자기 자신은 팔로우 할 수 없습니다."),
        NOT_MATCHED_PASSWORD(HttpStatus.BAD_REQUEST, "비밀번호가 다릅니다."),
        NOT_VALID_EMAIL(HttpStatus.BAD_REQUEST, "옳바르지 않은 이메일 주소입니다."),
        EXISTS_EMALL(HttpStatus.BAD_REQUEST, "이미 사용중인 이메일 주소 입니다."),

        /* 401 UNAUTHORIZED : 인증되지 않은 사용자 */
        INVALID_AUTH_TOKEN(HttpStatus.UNAUTHORIZED, "권한 정보가 없는 토큰입니다."),
        UNAUTHORIZED_MEMBER(HttpStatus.UNAUTHORIZED, "현재 내 계정 정보가 존재하지 않습니다."),

        /* 404 NOT_FOUND : Resource 를 찾을 수 없음 */
        USER_NOT_FOUND(HttpStatus.NOT_FOUND, "해당 유저 정보를 찾을 수 없습니다."),
        REFRESH_TOKEN_NOT_FOUND(HttpStatus.NOT_FOUND, "로그아웃 된 사용자입니다."),
        NOT_FOLLOW(HttpStatus.NOT_FOUND, "팔로우 중이지 않습니다."),

        /* 409 CONFLICT : Resource 의 현재 상태와 충돌. 보통 중복된 데이터 존재 */
        DUPLICATE_RESOURCE(HttpStatus.CONFLICT, "데이터가 이미 존재합니다."),
        DUPLICATE_EMAIL(HttpStatus.CONFLICT, "이메일이 이미 존재합니다.")

        ;

        private final HttpStatus httpStatus;
        private final String detail;
    }
}
