package com.moseoh.assistant.csttec.application;

import com.moseoh.assistant.csttec.dto.LoginRequest;
import com.moseoh.assistant.config.exception.ApiException;
import com.moseoh.assistant.csttec.dto.LoginResponse;
import com.moseoh.assistant.csttec.dto.base.BaseRequestDto;
import com.moseoh.assistant.csttec.dto.base.BaseResponseDto;
import com.moseoh.assistant.response.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.Objects;

@Slf4j
@Component
public class CsttecClient {

    private final WebClient webClient;

    public CsttecClient(CsttecClientBuilder csttecClientBuilder) {
        this.webClient = csttecClientBuilder.build();
    }

    private <T extends BaseResponseDto> Object request(BaseRequestDto requestDto, Class<T> responseDto, String service) {
        requestDto.setService(service);
        BaseResponseDto baseResponseDto = webClient
                .post()
                .contentType(MediaType.APPLICATION_JSON)
                .body(Mono.just(requestDto), requestDto.getClass())
                .retrieve()
                .bodyToMono(responseDto)
                .block();

        if (!Objects.requireNonNull(baseResponseDto).isSuccess()) {
            throw new ApiException(ErrorCode.INTERNAL_SERVER_ERROR, baseResponseDto.getMessage());
        }

        return baseResponseDto;
    }

    public LoginResponse login(LoginRequest loginRequestDto) {
        return (LoginResponse) request(loginRequestDto, LoginResponse.class, "common.Login");
    }
}
