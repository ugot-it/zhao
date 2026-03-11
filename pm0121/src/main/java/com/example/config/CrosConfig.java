package com.example.config;

import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

public class CrosConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
       registry.addMapping("/**")
               .allowedOrigins("*")
               .allowCredentials(true)
               .allowedMethods("GET", "POST", "PUT", "DELETE")
               .maxAge(3600).allowedHeaders("*");
    }
}
