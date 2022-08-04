package com.moseoh.assistant.controller;

import com.moseoh.assistant.dto.ReloadRequestDto;
import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.service.CodeService;
import com.moseoh.assistant.service.ConvertService;
import com.moseoh.assistant.service.TableService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/v1/code")
public class CodeController {

    private final CodeService codeService;
    private final TableService tableService;
    private final ConvertService convertService;

    @PostMapping("/reload")
    public ResponseEntity<Response> reload(@RequestBody ReloadRequestDto reloadRequestDto) {
        return Response.toResponseEntity(codeService.reload(reloadRequestDto));
    }

    @GetMapping("/tablenames")
    public ResponseEntity<Response> tableNames(@RequestParam String databaseName) {
        return Response.toResponseEntity(tableService.getTableNames(databaseName));
    }

    @GetMapping("/table")
    public ResponseEntity<Response> table(@RequestParam String databaseName, @RequestParam String tablename) {
        return Response.toResponseEntity(tableService.getTable(databaseName, tablename));
    }

    @GetMapping("/domain")
    public ResponseEntity<Response> domain(@RequestParam Long mtableId) {
        return Response.toResponseEntity(convertService.getDomain(mtableId));
    }

    @GetMapping("/mapper")
    public ResponseEntity<Response> mapper(@RequestParam Long mtableId) {
        return Response.toResponseEntity(convertService.getMapper(mtableId));
    }

    @GetMapping("/mybatis")
    public ResponseEntity<Response> mybatis(@RequestParam Long mtableId) {
        return Response.toResponseEntity(convertService.getMybatis(mtableId));
    }

}
