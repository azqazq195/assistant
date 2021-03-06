package com.moseoh.assistant.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.moseoh.assistant.utils.config.YAMLConfig;

import org.kohsuke.github.GHAsset;
import org.kohsuke.github.GHRelease;
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GitHub;
import org.kohsuke.github.GitHubBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GitService {

    private GitHub gitHub;
    private GHRepository repository;
    private String repositoryName = "azqazq195/assistant";

    @Autowired
    public GitService(YAMLConfig yamlConfig) throws IOException {
        this.gitHub = new GitHubBuilder().withOAuthToken(yamlConfig.getToken()).build();
        this.gitHub.checkApiUrlValidity();
        this.repository = this.gitHub.getRepository(this.repositoryName);
    }

    public List<Map<String, Object>> getReleaseList() {
        List<Map<String, Object>> releaseList = new ArrayList<>();
        int count = 10;
        try {
            for (GHRelease ghRelease : repository.listReleases()) {
                if (count-- < 0)
                    break;
                releaseList.add(
                        new HashMap<String, Object>() {
                            {
                                put("name", ghRelease.getName());
                                put("tagName", ghRelease.getTagName());
                                put("body", ghRelease.getBody());
                                put("createdAt", ghRelease.getCreatedAt());
                                put("url", ghRelease.getUrl());
                            }
                        });
            }

            return releaseList;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public Map<String, Object> getReleaseLatest() {
        try {
            GHRelease ghRelease = repository.getLatestRelease();
            GHAsset[] ghAssets = ghRelease.listAssets().toArray();
            if (ghAssets.length > 0) {
                return new HashMap<String, Object>() {
                    {
                        put("name", ghRelease.getName());
                        put("tagName", ghRelease.getTagName());
                        put("body", ghRelease.getBody());
                        put("createdAt", ghRelease.getCreatedAt());
                        put("url", ghRelease.getUrl());
                        put("downloadUrl", ghAssets[0].getBrowserDownloadUrl());
                    }
                };
            } else {
                return new HashMap<String, Object>() {
                    {
                        put("name", ghRelease.getName());
                        put("tagName", ghRelease.getTagName());
                        put("body", ghRelease.getBody());
                        put("createdAt", ghRelease.getCreatedAt());
                        put("url", ghRelease.getUrl());
                    }
                };
            }
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
