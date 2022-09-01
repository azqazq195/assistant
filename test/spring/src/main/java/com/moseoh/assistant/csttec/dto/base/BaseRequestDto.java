package com.moseoh.assistant.csttec.dto.base;

import lombok.*;

import javax.persistence.MappedSuperclass;

@Getter
@MappedSuperclass
public abstract class BaseRequestDto {
    String service;

    public void setService(String service) {
        this.service = service;
    }
}
