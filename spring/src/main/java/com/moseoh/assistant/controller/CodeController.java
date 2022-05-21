package com.moseoh.assistant.controller;

import com.moseoh.assistant.dto.ReloadReqeustDto;
import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.service.CodeService;
import com.moseoh.assistant.service.TableService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/v1/code")
public class CodeController {

    private final CodeService codeService;
    private final TableService tableService;

    @PostMapping("/reload")
    public ResponseEntity<Response> reload(@RequestBody ReloadReqeustDto reloadReqeustDto) {
        return Response.toResponseEntity(codeService.reload(reloadReqeustDto));
    }

    @GetMapping("/tablenames")
    public ResponseEntity<Response> tablenames(@RequestParam String databaseName) {
        return Response.toResponseEntity(tableService.getTableNames(databaseName));
    }

    @GetMapping("/table")
    public ResponseEntity<Response> table(@RequestParam String databaseName, @RequestParam String tablename) {
        return Response.toResponseEntity(tableService.getTable(databaseName, tablename));
    }

    @GetMapping("/domain")
    public ResponseEntity<Response> domain(@RequestParam Long mtableId) {
        return Response.toResponseEntity(tableService.getDomainData(mtableId));
    }

}
