package com.example.DTO;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
@Data
public class CartDetailDTO {
    private Long id;            // 购物车ID
    private Long userId;        // 用户ID
    private Long productId;     // 商品ID
    private Integer quantity;   // 数量
    private LocalDateTime createdTime; // 创建时间

    private String productName; // 商品名称
    private BigDecimal productPrice; // 商品价格
    private String productImage;
    public BigDecimal getSubtotal() {
        return productPrice.multiply(BigDecimal.valueOf(quantity));
    }
}

