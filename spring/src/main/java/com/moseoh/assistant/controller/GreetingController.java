package com.moseoh.assistant.controller;

import com.moseoh.assistant.entity.Greeting;
import com.moseoh.assistant.service.GreetingService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("greeting")
public class GreetingController {

    @Autowired
    private GreetingService greetingService;

    @GetMapping("/{id}")
    public Greeting findById(@PathVariable("id") long id) {
        return greetingService.findById(id);
    }

    @PostMapping
    public long save(@RequestBody Greeting greeting) {
        return greetingService.save(greeting);
    }
}
