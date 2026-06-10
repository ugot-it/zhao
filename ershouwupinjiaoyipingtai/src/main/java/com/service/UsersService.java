package com.service.impl;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.entity.UsersEntity;
import com.utils.PageUtils;

import java.util.List;
import java.util.Map;
/**
 * @author 朝
 * @ClassName: UsersService
 * @Description: 用户
 * @date 2026-05-20  下午 3:15
 * @Version:
 */


public interface UsersService extends IService<UsersEntity> {
    PageUtils queryPage(Map<String, Object> params);

    List<UsersEntity> selectListView(Wrapper<UsersEntity> wrapper);

    PageUtils queryPage(Map<String, Object> params, Wrapper<UsersEntity> wrapper);

}
