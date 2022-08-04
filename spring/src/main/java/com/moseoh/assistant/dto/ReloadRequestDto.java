package com.moseoh.assistant.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReloadRequestDto {
    private String dbPopulate;
    private String centerDbPopulate;
}