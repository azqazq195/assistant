package com.moseoh.assistant.client;

import com.moseoh.assistant.client.dto.LoginRequestDto;
import com.moseoh.assistant.client.dto.LoginResponseDto;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Component
public class CsttecClient {

    private final WebClient webClient;

    public CsttecClient(CsttecClientBuilder csttecClientBuilder) {
        this.webClient = csttecClientBuilder.build();
    }

    public LoginResponseDto login(LoginRequestDto loginRequestDto) {
        return webClient
                .post()
                .contentType(MediaType.APPLICATION_JSON)
                .body(Mono.just(loginRequestDto), LoginRequestDto.class)
                .retrieve()
                .bodyToMono(LoginResponseDto.class)
                .block();
    }
}
