package com.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

/**
 * @author 朝
 * @ClassName: RedisConfig
 * @Description: TODO(如何把java对象存储到redis然后再从里面读出来。)
 * @date 2026-06-21  上午 2:17
 * @Version:
 */
@Configuration
public class RedisConfig {
    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        //设置 Redis 连接工厂
        template.setConnectionFactory(connectionFactory);

        // 序列化设置（
        template.setKeySerializer(new StringRedisSerializer());
        // Value 用 JSON 序列化（存成 JSON 格式）
        template.setValueSerializer(new GenericJackson2JsonRedisSerializer());
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(new GenericJackson2JsonRedisSerializer());

        template.afterPropertiesSet();// 初始化完成
        return template;
    }
}
