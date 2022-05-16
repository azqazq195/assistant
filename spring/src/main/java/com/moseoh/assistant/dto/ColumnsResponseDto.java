package com.moseoh.assistant.dto;

import java.util.List;
import java.util.Map;

import com.moseoh.assistant.entity.MColumn;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ColumnsResponseDto {
    private Map<String, Object> data;
}
