package com.example.service.impl;

import com.example.common.Result;
import com.example.entity.Admin;
import com.example.mapper.AdminMapper;
import com.example.service.IAdminService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author H
 * @since 2025-04-20
 */
@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements IAdminService {
    @Override
    public Result<String> register(Admin admin) {
        // 检查用户名是否已存在
        Long count = lambdaQuery()
                .eq(Admin::getUsername, admin.getUsername())
                .count();
        if (count > 0) {
            return Result.error("用户名已存在");
        }
        // 保存管理员（密码明文存储）
        save(admin);
        return Result.success("注册成功");
    }
    // 登录验证方法
    @Override
    public Result<Admin> login(String username, String password) {
        // 根据用户名查询管理员
        Admin admin = lambdaQuery()
                .eq(Admin::getUsername, username)
                .one();
        // 用户不存在
        if (admin == null) {
            return Result.error("用户名不存在");
        }
        // 密码验证
        if (!password.equals(admin.getPassword())) {
            return Result.error("密码错误");
        }
        // 登录成功，返回管理员信息（隐藏密码）
        admin.setPassword(null); // 不返回密码
        // 5. 设置Cookie（安全实现）
        HttpServletResponse response = ((ServletRequestAttributes)
                RequestContextHolder.currentRequestAttributes()).getResponse();
        Cookie userCookie = new Cookie("userId"+admin.getUsername(),admin.getId().toString());
        userCookie.setHttpOnly(true); // 防止XSS
        userCookie.setPath("/"); // 全局有效
        userCookie.setMaxAge(7 * 24 * 60 * 60); // 7天有效期
        response.addCookie(userCookie);
        return Result.success(admin);
    }


    @Override
    public Admin getUserById(String userId) {
        return this.getById(userId);
    }

    @Override
    public Result<String> updateUser(Admin admin) {
        boolean success = this.updateById(admin);
        if(success) {
            return Result.success("更新成功");
        }
        return Result.error("更新失败");
    }
}
