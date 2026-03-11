package com.example.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;



@Getter
@Setter
@ToString
@TableName("product")
public class Product implements Serializable{


        private static final long serialVersionUID = 1L;

        @TableId(value = "id", type = IdType.AUTO) // 主键自增
        private Integer id;

        @TableField("name") // 对应name字段
        private String name;

        @TableField("description") // 商品描述
        private String description;

        @TableField("price") // 商品价格
        private BigDecimal price; // 使用BigDecimal避免精度问题

        @TableField("stock") // 库存数量
        private Integer stock;

        @TableField("category_id") // 分类ID
        private Integer categoryId;

        @TableField("image_url") // 商品图片URL
        private String imageUrl;

        @TableField("status") // 商品状态：1-上架 0-下架
        private Integer status;

        @TableField(fill = FieldFill.INSERT) // 创建时自动填充
        private Date createTime;

        @TableField(fill = FieldFill.INSERT_UPDATE) // 创建和更新时自动填充
        private Date updateTime;


}
