package com.moseoh.assistant.utils;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class YamlTest {

    @Autowired
    private YAMLConfig yamlConfig;

    @Test
    public void testKey() {
        assertEquals("testKey", yamlConfig.getTestKey());
    }

}
