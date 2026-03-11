package com.example.service;

import com.example.common.Result;
import com.example.entity.Admin;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


/**
 * <p>
 *  服务类
 * </p>
 *
 * @author H
 * @since 2025-04-20
 */
public interface IAdminService extends IService<Admin> {
    // 自定义注册方法
    Result<String> register(Admin admin);
    // 登录方法
    Result<Admin> login(String username, String password);
    //获取用户id
    Admin getUserById(String userId);
    //信息更新
    Result<String> updateUser(Admin admin);
}
