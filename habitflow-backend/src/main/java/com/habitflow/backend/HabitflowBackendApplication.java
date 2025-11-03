package com.habitflow.backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@EnableCaching
public class HabitflowBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(HabitflowBackendApplication.class, args);
    }
}
