package com.example.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.common.Result;
import com.example.entity.Admin;
import com.example.entity.Order;
import com.example.entity.Product;
import com.example.mapper.ProductMapper;
import com.example.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;


    // 创建订单
    @PostMapping("/create")
    public Result<Map<String, String>> createOrder(
            @RequestParam Long userId,
            @RequestParam List<Integer> productId,
            @RequestParam List<Integer> quantity,
            @RequestParam String address,
            @RequestParam String receiverName,
            @RequestParam String receiverPhone

    ) {
        //验证参数，将商品数量也修改成了数组。
        //需要注意的是，数量和商品id要长度一致，因为需要这两个值一一对应。
        if (userId == null || productId.size()==0 || quantity.size()==0 || quantity == null || productId.size() != quantity.size()|| StringUtils.isBlank(address) ||StringUtils.isBlank(receiverName) || StringUtils.isBlank(receiverPhone)) {
            return Result.error("参数不合法");
        }
        // 调用服务层创建订单
        return orderService.createOrder(userId, productId, quantity, address, receiverName, receiverPhone);
    }


    @GetMapping("/list")
    public Result<IPage<Order>> list(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) String userId) {

        if (userId == null) {
            return Result.error("用户ID为空");
        }
        // 创建分页对象
        Page<Order> page = new Page<>(pageNum, pageSize);

        // 调用Service
        IPage<Order> pageResult = orderService.getOrderListByUserId(page, userId);

        return Result.success(pageResult);

    }
//查
    @GetMapping("/{orderId}")
    public Result<Order> detail(@PathVariable String orderId) {
        return orderService.getOrderDetail(orderId);
    }

//取消订单
    @PostMapping("/cancel/{orderId}")
    public Result<String> cancelOrder(@PathVariable String orderId) {
        return orderService.cancelUnpaidOrder(orderId);
    }


}