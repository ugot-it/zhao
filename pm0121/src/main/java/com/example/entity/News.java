package com.example.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;


import java.time.LocalDateTime;


    @Data
    @TableName("hot_news")
    public class News {
        @TableId(type = IdType.AUTO)
        private Integer id;

        private String title;
        private String description;

        @TableField("image_url")  // 明确指定数据库字段名
        private String imageUrl;

        private String link;

        @TableField("is_active")
        private Boolean isActive;

        @TableField("sort_order")
        private Integer sortOrder;

        @TableField("create_time")
        private LocalDateTime createTime;

        @TableField("update_time")
        private LocalDateTime updateTime;
    }
