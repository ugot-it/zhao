package com.example.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.common.Result;
import com.example.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/favorite")
public class FavoriteController {
    @Autowired
    private FavoriteService favoriteService;

    // 添加收藏
    @PostMapping("/add")
    public Result<String> addFavorite(
            @RequestParam Long userId,
            @RequestParam Long productId) {
        return favoriteService.addFavorite(userId, productId);
    }

    // 取消收藏
    @DeleteMapping("/remove")
    public Result<String> removeFavorite(
            @RequestParam Long userId,
            @RequestParam Long productId) {
        return favoriteService.removeFavorite(userId, productId);
    }

    // 收藏列表
    @GetMapping("/list")
    public Result<List<Map<String, Object>>> getFavoriteList(
            @RequestParam Long userId) {
        return favoriteService.getFavoriteList(userId);
    }


}