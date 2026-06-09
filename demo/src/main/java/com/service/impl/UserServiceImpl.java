package com.service.impl;

/**
 * @author 朝
 * @ClassName: UserServiceImpl
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @date 2026-05-20  下午 3:17
 * @Version:
 */


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.dao.UsersDao;
import com.entity.UsersEntity;
import com.utils.PageUtils;
import com.utils.Query;

@Service("userService")
public class UsersServiceImpl extends ServiceImpl<UsersDao, UsersEntity> implements UsersService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<UsersEntity> page = this.selectPage(
                new Query<UsersEntity>(params).getPage(),
                new EntityWrapper<UsersEntity>()
        );
        return new PageUtils(page);
    }

    @Override
    public List<UsersEntity> selectListView(Wrapper<UsersEntity> wrapper) {
        return baseMapper.selectListView(wrapper);
    }

    @Override
    public PageUtils queryPage(Map<String, Object> params,
                               Wrapper<UsersEntity> wrapper) {
        Page<UsersEntity> page =new Query<UsersEntity>(params).getPage();
        page.setRecords(baseMapper.selectListView(page,wrapper));
        PageUtils pageUtil = new PageUtils(page);
        return pageUtil;
    }
}
