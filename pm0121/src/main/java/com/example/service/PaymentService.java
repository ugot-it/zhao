package com.example.service;
import com.example.common.Result;
public interface PaymentService {
    /**
     * 处理支付请求
     * @param orderId 订单ID
     * @param userId 用户ID
     * @return 支付结果
     */
    Result<String> processPayment(String orderId, String userId);
}