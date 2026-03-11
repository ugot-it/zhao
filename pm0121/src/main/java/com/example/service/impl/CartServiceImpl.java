package com.example.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.DTO.CartDetailDTO;
import com.example.common.Result;
import com.example.entity.Cart;
import com.example.entity.Product;
import com.example.mapper.CartMapper;
import com.example.service.CartService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;


@Service
public class CartServiceImpl extends ServiceImpl<CartMapper, Cart> implements CartService {
    private final CartMapper cartMapper;

    public CartServiceImpl(CartMapper cartMapper) {
        this.cartMapper = cartMapper;
    }


    //获取巨多消息，无敌烦死了
    @Override
    public List<CartDetailDTO>  selectCartDetailsByUserId(Long userId) {

        // 参数校验
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        return cartMapper.selectCartDetailsByUserId(userId);
    }


    @Override
    @Transactional
    public Result<String> addCartItem(Long userId, Long productId, Integer quantity) {
        // 参数校验
        if (userId == null || productId == null) {
            return Result.error("参数错误：用户ID和商品ID不能为空");
        }
        if (quantity == null || quantity <= 0) {
            quantity = 1; // 默认数量为1
        }

        // 检查是否已存在
        LambdaQueryWrapper<Cart> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Cart::getUserId, userId)
                .eq(Cart::getProductId, productId);

        Cart existingItem = this.getOne(wrapper);

        if (existingItem != null) {
            // 存在则更新数量
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
            this.updateById(existingItem);
            return Result.success("购物车商品数量已更新");
        }

        // 不存在则新增
        Cart newItem = new Cart();
        newItem.setUserId(userId);
        newItem.setProductId(productId);
        newItem.setQuantity(quantity);
        newItem.setCreatedTime(LocalDateTime.now());
        this.save(newItem);

        return Result.success("商品已添加到购物车");
    }

    @Override
    @Transactional
    public Result<String> updateCartItemQuantity(Long userId, Long productId, Integer quantity) {
        if (quantity == null || quantity <= 0) {
            return Result.error("数量必须大于0");
        }

        LambdaUpdateWrapper<Cart> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(Cart::getUserId, userId)
                .eq(Cart::getProductId, productId)
                .set(Cart::getQuantity, quantity);

        return this.update(wrapper) ?
                Result.success("数量更新成功") :
                Result.error("商品不在购物车中");
    }

    @Override
    @Transactional
    public Result<String> removeCartItem(Long userId, Long productId) {
        LambdaQueryWrapper<Cart> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Cart::getUserId, userId)
                .eq(Cart::getProductId, productId);

        return this.remove(wrapper) ?
                Result.success("商品已移除") :
                Result.error("商品不在购物车中");
    }

    @Override
    @Transactional
    public Result<String> clearUserCart(Long userId) {
        LambdaQueryWrapper<Cart> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Cart::getUserId, userId);

        this.remove(wrapper);
        return Result.success("购物车已清空");
    }

}