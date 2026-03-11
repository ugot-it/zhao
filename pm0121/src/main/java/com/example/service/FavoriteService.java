package com.example.service;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.common.Result;
import com.example.entity.Favorite;
import java.util.List;
import java.util.Map;

public interface FavoriteService extends IService<Favorite> {

    /**
     * 添加收藏
     * @param userId 用户ID
     * @param productId 商品ID
     * @return 操作结果
     */
    Result<String> addFavorite(Long userId, Long productId);

    /**
     * 取消收藏
     * @param userId 用户ID
     * @param productId 商品ID
     * @return 操作结果
     */
    Result<String> removeFavorite(Long userId, Long productId);

    /**
     * 获取用户收藏列表
     * @param userId 用户ID
     * @return 收藏列表(包含商品信息)
     */
    Result<List<Map<String, Object>>> getFavoriteList(Long userId);


}