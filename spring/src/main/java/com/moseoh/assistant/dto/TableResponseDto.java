package com.moseoh.assistant.dto;

import com.moseoh.assistant.entity.MTable;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class TableResponseDto {
    private MTable svnTable;
    private MTable userTable;
}
