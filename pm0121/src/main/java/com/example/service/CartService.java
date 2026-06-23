package com.example.service;

import com.example.DTO.CartDetailDTO;
import com.example.common.Result;
import com.example.entity.Cart;

import java.util.List;

public interface CartService {
    /**
     * 获取用户购物车所有商品
     */
    List<CartDetailDTO> selectCartDetailsByUserId(Long userId);

    /**
     * 获取用户购物车所有商品
     *
     * @return 购物车商品列表
     */
    Result<String> addCartItem(Long userid, Long productid, Integer quantity);
    /**
     * 更新购物车商品数量
     */
    Result<String> updateCartItemQuantity(Long userid, Long productid, Integer quantity);
    /**
     * 从购物车移除商品
     */
    Result<String> removeCartItem(Long userid, Long productid);
    /**
     * 清空用户购物车
     */
    Result<String> clearUserCart(Long userid);

}
