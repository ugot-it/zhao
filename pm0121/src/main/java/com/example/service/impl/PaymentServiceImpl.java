package com.example.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.example.common.Result;
import com.example.entity.Order;
import com.example.mapper.OrderMapper;
import com.example.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class PaymentServiceImpl implements PaymentService {

    @Autowired
    private OrderMapper orderMapper;

    @Override
    @Transactional
    public Result<String> processPayment(String orderId, String userId) {
        // 1. 验证订单
        Order order = orderMapper.selectById(orderId);
        if (order == null) {
            return Result.error("订单不存在");
        }


        // 检查订单状态是否为未支付(0)
        if (order.getStatus() != 0) {
            return Result.error(order.getStatus() == 1 ? "订单已支付" : "订单状态异常");
        }

        // 直接更新订单状态为已支付(1)
        order.setStatus(1); // 1表示已支付
        order.setUpdateTime(LocalDateTime.now()); // 更新修改时间

        int result = orderMapper.updateById(order);

        // 返回结果
        return result > 0 ? Result.success("支付成功") : Result.error("支付失败");
    }
}