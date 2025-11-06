package com.habitflow.backend;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication(scanBasePackages = "com.habitflow.backend")
@EnableCaching
public class HabitflowBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(HabitflowBackendApplication.class, args);
    }
    @Bean
    CommandLineRunner verifyControllers(ApplicationContext ctx) {
        return args -> {
            System.out.println("====== Registered @RestController Beans ======");
            String[] beans = ctx.getBeanNamesForAnnotation(RestController.class);
            for (String name : beans) {
                System.out.println(" - " + name);
            }
            System.out.println("=============================================");
        };
    }
}
