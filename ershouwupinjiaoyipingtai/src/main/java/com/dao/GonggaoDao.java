package com.dao;

import com.entity.GonggaoEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.view.GonggaoView;


/**
 * @author 朝
 * @ClassName: GonggaoDao
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @date 2026-06-21  上午 2:27
 * @Version:
 */

    public interface GonggaoDao extends BaseMapper<GonggaoEntity> {

        List<GonggaoView> selectListView(Pagination page, @Param("params") Map<String,Object> params);

    }

