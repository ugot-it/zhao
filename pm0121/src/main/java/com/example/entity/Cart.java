package com.example.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.annotation.TableName;
import jakarta.persistence.Entity;
import lombok.Data;
import com.baomidou.mybatisplus.annotation.TableId;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName( "cart")
public class Cart {

        @TableId(type = IdType.AUTO)
        private Long id;

        @TableField("user_id")
        private Long userId;
        @TableField("product_id")
        private Long productId;

        private Integer quantity;
        private LocalDateTime createdTime;

/*        // 新增，我需要商品名和商品价格
        @TableField(exist = false)
        private String productName;

        @TableField(exist = false)
        private BigDecimal productPrice;
        //债多不压身，再来点图片。
        @TableField(exist = false)
        private String productImage;*/


}
