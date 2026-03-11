package com.example.service.impl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.common.Result;
import com.example.entity.Favorite;
import com.example.entity.Product;
import com.example.mapper.FavoriteMapper;
import com.example.mapper.ProductMapper;
import com.example.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class FavoriteServiceImpl extends ServiceImpl<FavoriteMapper, Favorite> implements FavoriteService {

    @Autowired
    private ProductMapper productMapper;

    @Override
    @Transactional
    public Result<String> addFavorite(Long userId, Long productId) {
        // 检查商品是否存在
        if (productMapper.selectById(productId) == null) {
            return Result.error("商品不存在");
        }

        // 检查是否已收藏
        LambdaQueryWrapper<Favorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Favorite::getUserId, userId)
                .eq(Favorite::getProductId, productId);
        if (this.count(wrapper) > 0) {
            return Result.error("您已收藏过该商品");
        }

        // 创建收藏记录
        Favorite favorite = new Favorite();
        favorite.setUserId(userId);
        favorite.setProductId(productId);
        this.save(favorite);

        return Result.success("收藏成功");
    }
//取消收藏
    @Override
    @Transactional
    public Result<String> removeFavorite(Long userId, Long productId) {
        LambdaQueryWrapper<Favorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Favorite::getUserId, userId)
                .eq(Favorite::getProductId, productId);

        return this.remove(wrapper) ?
                Result.success("取消收藏成功") :
                Result.error("取消收藏失败");
    }
//查询收藏列表
    @Override
    public Result<List<Map<String, Object>>> getFavoriteList(Long userId) {
        // 使用MyBatis-Plus的查询构造器
        QueryWrapper<Favorite> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId)
                .orderByDesc("create_time");

        // 获取收藏列表
        List<Favorite> favorites = this.list(queryWrapper);

        // 转换为包含商品信息的Map列表
        List<Map<String, Object>> result = favorites.stream().map(favorite -> {
            Map<String, Object> map = new HashMap<>();
            Product product = productMapper.selectById(favorite.getProductId());

            map.put("id", favorite.getId());
            map.put("productId", favorite.getProductId());
            if (product != null) {
                map.put("productName", product.getName());
                map.put("productImage", product.getImageUrl());
                map.put("productPrice", product.getPrice());
            }
            map.put("createTime", favorite.getCreateTime());

            return map;
        }).collect(Collectors.toList());

        return Result.success(result);
    }

}