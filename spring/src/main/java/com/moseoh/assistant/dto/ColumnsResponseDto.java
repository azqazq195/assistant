package com.moseoh.assistant.dto;

import java.util.List;

import com.moseoh.assistant.entity.MColumn;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ColumnsResponseDto {
    private List<MColumn> svnColumns;
    private List<MColumn> userColumns;
}
