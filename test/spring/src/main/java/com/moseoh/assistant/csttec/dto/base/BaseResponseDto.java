package com.moseoh.assistant.csttec.dto.base;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;

import javax.persistence.MappedSuperclass;

@Getter
@MappedSuperclass
public abstract class BaseResponseDto {
    @JsonProperty(value = "success")
    private boolean success;
    @JsonProperty(value = "rollback")
    private boolean rollback;
    @JsonProperty(value = "proceedable")
    private boolean proceedable;
    @JsonProperty(value = "print_notice")
    private boolean printNotice;
    @JsonProperty(value = "service")
    private String service;
    @JsonProperty(value = "message_title")
    private String messageTitle;
    @JsonProperty(value = "message")
    private String message;
}
