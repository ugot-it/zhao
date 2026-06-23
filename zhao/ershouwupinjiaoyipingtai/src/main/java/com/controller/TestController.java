package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
/**
* @ClassName: TestController
* @Description: TODO(这里用一句话描述这个类的作用)
* @author 朝
* @date 2026-06-21  上午 1:58
* @Version: 
*/



@RestController
@RequestMapping("/test")
public class TestController {

    @Autowired
    private StringRedisTemplate redisTemplate;

    // Redis 测试接口
    @GetMapping("/redis")
    public Map<String, Object> testRedis() {
        Map<String, Object> result = new HashMap<>();
        try {
            // 存数据
            redisTemplate.opsForValue().set("test:key", "Hello Redis!");
            // 取数据
            String value = redisTemplate.opsForValue().get("test:key");

            result.put("success", true);
            result.put("message", "Redis 连接成功！");
            result.put("data", value);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Redis 连接失败：" + e.getMessage());
        }
        return result;
    }
}