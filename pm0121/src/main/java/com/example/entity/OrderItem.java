package com.example.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;

@Data
@TableName("order_item")
public class OrderItem {
    @TableId(type = IdType.ASSIGN_ID)//主键
    private String id;

    @TableField("order_id")
    private String orderId;     // 关联order_detail.id

    @TableField("product_id")
    private Integer productId;     // 商品ID

    private Integer quantity;
    private BigDecimal price;


}
