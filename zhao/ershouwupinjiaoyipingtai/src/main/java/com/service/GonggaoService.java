package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.GonggaoEntity;
import java.util.Map;
/**
 * @author 朝
 * @ClassName: GonggaoService
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @date 2026-06-21  上午 2:24
 * @Version:
 */
public interface GonggaoService extends IService<GonggaoEntity> {
    /**
     * @param params 查询参数
     * @return 带分页的查询出来的数据
     */
    PageUtils queryPage(Map<String, Object> params);

}

