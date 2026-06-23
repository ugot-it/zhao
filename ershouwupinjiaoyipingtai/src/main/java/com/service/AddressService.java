package com.service.impl;

/**
 * @author 朝
 * @ClassName: AddressService
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @date 2026-05-20  下午 3:06
 * @Version:
 */
 
import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.AddressEntity;
import java.util.Map;

/**
 * 收货地址 服务类
 */
public interface AddressService extends IService<AddressEntity> {

    /**
     * @param params 查询参数
     * @return 带分页的查询出来的数据
     */
    PageUtils queryPage(Map<String, Object> params);

}