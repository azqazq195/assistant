package com.moseoh.assistant.service;

import com.moseoh.assistant.entity.MColumn;
import com.moseoh.assistant.repository.ColumnRepository;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ColumnService {
    private final ColumnRepository columnRepository;

    public void save(MColumn column) {
        MColumn currentColumn = columnRepository.findByNameAndMtableId(column.getName(), column.getMtable().getId());
        if (currentColumn != null) {
            column.setId(currentColumn.getId());
        }
        columnRepository.save(column);
    }
}
