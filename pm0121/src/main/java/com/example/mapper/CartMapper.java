package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.DTO.CartDetailDTO;
import com.example.entity.Cart;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CartMapper extends BaseMapper<Cart> {
    // 基础CRUD操作已由BaseMapper提供



    @Select("SELECT c.id, c.user_id, c.product_id, c.quantity, c.created_time, " +
            "p.name AS product_name, p.price AS product_price , p.image_url AS product_image "  +
            "FROM cart c " +
            "LEFT JOIN product p ON c.product_id = p.id " +
            "WHERE c.user_id = #{userId} " +
            "ORDER BY c.created_time DESC")
    List<CartDetailDTO> selectCartDetailsByUserId(@Param("userId") Long userId);

}