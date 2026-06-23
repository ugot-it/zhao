package com.service.impl;


import org.springframework.stereotype.Service;
import java.lang.reflect.Field;
import java.util.*;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import com.utils.PageUtils;
import com.utils.Query;
import org.springframework.web.context.ContextLoader;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.springframework.lang.Nullable;
import org.springframework.util.Assert;
import com.dao.GonggaoDao;
import com.entity.GonggaoEntity;
import com.service.GonggaoService;
import com.entity.view.GonggaoView;

/**
 * @author 朝
 * @ClassName: GonggaoServiceImpl
 * @Description: TODO(公告。)
 * @date 2026-06-21  上午 2:25
 * @Version:
 */

@Service("gonggaoService")
@Transactional
public class GonggaoServiceImpl  extends ServiceImpl<GonggaoDao, GonggaoEntity> implements GonggaoService{
    @Override
    public PageUtils queryPage(Map<String,Object> params) {
        Page<GonggaoView> page =new Query<GonggaoView>(params).getPage();
        page.setRecords(baseMapper.selectListView(page,params));
        return new PageUtils(page);
    }


}
