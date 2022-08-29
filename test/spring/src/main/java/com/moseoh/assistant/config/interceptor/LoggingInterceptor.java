package com.moseoh.assistant.config.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RequiredArgsConstructor
@Component
public class LoggingInterceptor implements HandlerInterceptor {

    private final ObjectMapper objectMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        log.info("-- [REQUEST] [{}] {}, param: '{}'", request.getMethod(), request.getRequestURI(), request.getQueryString());
        return HandlerInterceptor.super.preHandle(request, response, handler);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        final ContentCachingRequestWrapper cachingRequest = (ContentCachingRequestWrapper) request;
        final ContentCachingResponseWrapper cachingResponse = (ContentCachingResponseWrapper) response;
        String requestBody = String.valueOf(objectMapper.readTree(cachingRequest.getContentAsByteArray()));
        String responseBody = String.valueOf(objectMapper.readTree(cachingResponse.getContentAsByteArray()));
        log.info("-- [RESPONSE] [{}] {}, param: '{}'", request.getMethod(), request.getRequestURI(), request.getQueryString());
        if (ex == null) {
            log.info("-- request body: {}", requestBody);
            log.info("-- response body: {}", responseBody);
        } else {
            log.info("-- exception");
        }
        log.info("-- [END]");
        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
    }
}
