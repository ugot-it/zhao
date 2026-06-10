package com.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author 朝
 * @ClassName: Mybatis
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @date 2026-05-20  下午 2:47
 * @Version:
 */

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.baomidou.mybatisplus.mapper.MetaObjectHandler;
import com.baomidou.mybatisplus.plugins.PaginationInterceptor;
@Configuration
public class Mybatis {
        /**
         * 分页插件
         */
        @Bean
        public PaginationInterceptor paginationInterceptor() {
            return new PaginationInterceptor();
        }

    }

