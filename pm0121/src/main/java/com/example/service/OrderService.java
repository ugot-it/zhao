package com.example.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.entity.Order;
import com.example.common.Result;

import java.util.List;
import java.util.Map;

public interface OrderService extends IService<Order> {

    /**
     * 获取用户订单
     * @param userId
     * @return
     */
    IPage<Order> getOrderListByUserId(Page<Order> page, String userId);

    /**
     * 创建订单
     * @param userId 用户ID
     * @param productIds 商品IDs
     * @param quantities 数量
     * @return 包含订单ID和用户地址的结果
     */
    Result<Map<String, String>> createOrder(long userId, List<Integer> productIds, List<Integer> quantities,String address, String receiverName, String receiverPhone);

    /**
     * 根据订单ID查询详情
     * @param orderId 订单ID
     * @return 订单详情
     */
    Result<Order> getOrderDetail(String orderId);

    /**
     * 取消订单
     * @param orderId 订单ID
     * @return 操作结果
     */
    Result<String> cancelUnpaidOrder(String orderId);


}