package com.moseoh.assistant.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReloadReqeustDto {
    private String dbPopulate;
    private String centerDbPopulate;
}