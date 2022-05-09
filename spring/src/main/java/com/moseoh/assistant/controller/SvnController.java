package com.moseoh.assistant.controller;

import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.service.SvnService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import lombok.RequiredArgsConstructor;

@Api(tags = { "3. Svn" })
@RequiredArgsConstructor
@RestController
@RequestMapping("/v1/svn")
@ApiImplicitParams({
        @ApiImplicitParam(name = "X-AUTH-TOKEN", value = "AccessToken", required = true, dataType = "String", paramType = "header")
})
public class SvnController {

    private final SvnService svnService;

    @GetMapping("/export")
    public ResponseEntity<Response> export() {
        return Response.toResponseEntity(svnService.export());
    }
}
