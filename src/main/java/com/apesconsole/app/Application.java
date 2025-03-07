package com.apesconsole.app;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}

@RestController
class TestController {

	@Value("${my.secret}")
	private String secret;
	
    @GetMapping("/test")
    public String testSecret() {
        return "Received Secret: " + secret;
    }
}