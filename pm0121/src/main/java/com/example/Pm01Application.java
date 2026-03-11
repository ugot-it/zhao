package com.example;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

import java.util.Arrays;

@SpringBootApplication
@MapperScan("com.example.mapper")
public class Pm01Application {
    public static void main(String[] args) {
        SpringApplication.run(Pm01Application.class, args);
    }
    // 跨域配置
    private CorsConfiguration buildCorsConfig() {
        CorsConfiguration config = new CorsConfiguration();
        // 允许的域名（根据环境动态配置）
        config.setAllowedOrigins(Arrays.asList(
                "http://localhost:5173/"      // 前端开发环境
               // "https://your-production.com"  // 生产环境域名
        ));
        // 允许的请求头
        config.setAllowedHeaders(Arrays.asList("*")); // 或明确指定："Authorization", "Content-Type"
        // 允许的 HTTP 方法
        config.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        // 允许携带凭证（如 Cookie）
        config.setAllowCredentials(true);
        // 预检请求缓存时间
        config.setMaxAge(3600L);
        return config;
    }
    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", buildCorsConfig());
        return new CorsFilter(source);
    }
}
