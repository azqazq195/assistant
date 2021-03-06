package com.moseoh.assistant.controller;

import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.service.GitService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import lombok.RequiredArgsConstructor;

@Api(tags = { "2. Git" })
@RequiredArgsConstructor
@RestController
@RequestMapping("/v1/git")
@ApiImplicitParams({
        @ApiImplicitParam(name = "X-AUTH-TOKEN", value = "AccessToken", required = true, dataType = "String", paramType = "header")
})
public class GitController {

    private final GitService gitService;

    @GetMapping("/releases")
    public ResponseEntity<Response> getReleases() {
        return Response.toResponseEntity(gitService.getReleaseList());
    }

    @GetMapping("/releaseLatest")
    public ResponseEntity<Response> getReleaseLatest() {
        return Response.toResponseEntity(gitService.getReleaseLatest());
    }
}
