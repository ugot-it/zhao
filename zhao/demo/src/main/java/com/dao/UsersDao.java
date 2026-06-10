package com.dao;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.entity.UsersEntity;

/**
 * @author 朝
 * @ClassName: UsersDao
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @date 2026-05-20  下午 3:19
 * @Version:
 */

public interface UsersDao extends BaseMapper<UsersEntity> {

    List<UsersEntity> selectListView(@Param("ew") Wrapper<UsersEntity> wrapper);

    List<UsersEntity> selectListView(Pagination page, @Param("ew") Wrapper<UsersEntity> wrapper);

}
