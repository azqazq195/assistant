package com.moseoh.assistant.api;

import java.io.IOException;
import java.util.List;

import com.moseoh.assistant.utils.YAMLConfig;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.kohsuke.github.GHRelease;
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GitHub;
import org.kohsuke.github.GitHubBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class GitApiTest {

    private Logger logger = LoggerFactory.getLogger(GitApiTest.class);

    @Autowired
    private YAMLConfig yamlConfig;

    @DisplayName("git connection test.")
    @Test
    public void test() throws IOException {
        GitHub.connectUsingOAuth(yamlConfig.getToken());

        GitHub gitHub = new GitHubBuilder().withOAuthToken(yamlConfig.getToken()).build();
        gitHub.checkApiUrlValidity();

        GHRepository repo = gitHub.getRepository("azqazq195/assistant");
        List<GHRelease> releases = repo.listReleases().toList();
        logger.info(releases.toString());
    }
}
