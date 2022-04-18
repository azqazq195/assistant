package com.moseoh.assistant.service;

import java.util.Optional;

import com.moseoh.assistant.entity.Greeting;
import com.moseoh.assistant.repository.GreetingRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * GreetingService
 */
@Service
public class GreetingService {

    @Autowired
    private GreetingRepository greetingRepository;

    public Greeting findById(long id) {
        Optional<Greeting> greeting = greetingRepository.findById(id);
        return greeting.get();
    }

    public long save(Greeting greeting) {
        greetingRepository.save(greeting);
        return greeting.getId();
    }
}