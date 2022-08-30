package com.moseoh.assistant.client;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

@Component
public class CsttecClientBuilder {
    public WebClient build() {
        return WebClient
                .builder()
                .baseUrl("https://csweb.kncsoft.co.kr/json")
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .build();
    }
}
