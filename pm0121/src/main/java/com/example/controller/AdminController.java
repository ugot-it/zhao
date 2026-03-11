package com.example.controller;

import com.example.common.Result;
import com.example.entity.Admin;
import com.example.pojo.LoginRequest;
import com.example.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author H
 * @since 2025-04-20
 */
@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private IAdminService iadminService;


    // 获取用户信息接口
    @GetMapping("/getUserInfo")
    public Result<Admin> getUserInfo(@RequestParam String userId) {
        Admin admin = iadminService.getUserById(userId);
        return Result.success(admin);
    }

    // 更新用户信息接口
    @PostMapping("/updateUser")
    public Result<String> updateUser(@RequestBody Admin admin) {
        return iadminService.updateUser(admin);
    }

    // 管理员注册接口
    @PostMapping("/register")
    public Result<String> register(@RequestBody Admin admin) {
        return iadminService.register(admin);
    }
    // 管理员登录接口
    @PostMapping("/login")
    public Result<Admin> login(@RequestBody LoginRequest request) {
        return iadminService.login(request.getUsername(), request.getPassword());
    }

}
