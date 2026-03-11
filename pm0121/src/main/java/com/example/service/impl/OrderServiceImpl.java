package com.example.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.entity.Admin;
import com.example.entity.Order;
import com.example.entity.OrderItem;
import com.example.entity.Product;
import com.example.mapper.AdminMapper;
import com.example.mapper.OrderItemMapper;
import com.example.mapper.OrderMapper;
import com.example.mapper.ProductMapper;
import com.example.service.OrderService;
import com.example.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {
    @Autowired  // 添加自动注入注解
    private ProductMapper productMapper;

    @Autowired  // 添加自动注入
    private OrderItemMapper orderItemMapper;

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public IPage<Order> getOrderListByUserId(Page<Order> page, String userId) {
        // 1. 构建查询条件
        LambdaQueryWrapper<Order> wrapper = Wrappers.lambdaQuery();

        // 2. 动态条件
        wrapper.eq(Order::getUserId,Long.parseLong(userId));
        // 3. 排序
        wrapper.orderByDesc(Order::getCreateTime);

        // 4. 使用父类的page方法（来自ServiceImpl）
        return this.page(page, wrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Result<Map<String, String>> createOrder(long userId, List<Integer> productIds, List<Integer> quantities, String address, String receiverName, String receiverPhone) {
        // 参数校验
        if (productIds == null || productIds.isEmpty() || quantities == null || quantities.isEmpty()
                || productIds.size() != quantities.size()) {
            return Result.error("商品ID和数量列表不能为空且长度必须一致");
        }
        if (StringUtils.isBlank(address) || StringUtils.isBlank(receiverName) || StringUtils.isBlank(receiverPhone)) {
            return Result.error("收件人信息不能为空");
        }

        // 1. 查询所有商品信息，检查库存
        List<Product> products = productMapper.selectBatchIds(productIds);
        if (products.size() != productIds.size()) {
            return Result.error("部分商品不存在");
        }
        Map<Integer, Product> productMap = products.stream()
                .collect(Collectors.toMap(Product::getId, Function.identity()));
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (int i = 0; i < productIds.size(); i++) {
            Integer pid = productIds.get(i);
            Integer qty = quantities.get(i);
            Product product = productMap.get(pid);

            if (product.getStock() < qty) {
                return Result.error("商品 " + product.getName() + " 库存不足");
            }
            totalAmount = totalAmount.add(product.getPrice().multiply(BigDecimal.valueOf(qty)));
        }

        // 3. 保存订单主表(order_detail)
        Order order = new Order();
        order.setUserId(userId);
        order.setStatus(0); // 待支付状态
        order.setAddress(address);
        order.setTotalAmount(totalAmount);
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        this.save(order); // 自动生成order.id

        // 4. 保存订单商品项(order_item)
        for (int i = 0; i < productIds.size(); i++) {
            Integer pid = productIds.get(i);
            Integer qty = quantities.get(i);
            Product product = productMap.get(pid);

            OrderItem item = new OrderItem();
            item.setOrderId(order.getId());
            item.setProductId(pid);
            item.setQuantity(qty);
            item.setPrice(product.getPrice());
            orderItemMapper.insert(item);

            // 5. 扣减库存
            product.setStock(product.getStock() - qty);
            productMapper.updateById(product);
        }

        // 6. 返回订单信息
        Map<String, String> result = new HashMap<>();
        result.put("orderId", order.getId().toString());
        result.put("address", address);
        result.put("receiverName", receiverName);
        result.put("receiverPhone", receiverPhone);

        return Result.success(result);
    }

    @Override
    public Result<Order> getOrderDetail(String orderId) {
        Order order = this.getById(orderId);

        if (order == null) {
            return Result.error("订单不存在");
        }
        return Result.success(order);
    }

    @Override
    public Result<String> cancelUnpaidOrder(String orderId) {
        // 订单是否存在
        Order order = this.getById(orderId);
        if (order == null) {
            return Result.error("订单不存在");
        }

        // 订单状态是否为0
        if (order.getStatus() != 0) {
            return Result.error("只有未支付订单可以取消");
        }

        //更新订单状态为已取消
        order.setStatus(4);
        order.setUpdateTime(LocalDateTime.now());

        //执行更新
        boolean success = this.updateById(order);
        if (success) {
            return Result.success("订单取消成功");
        }
        return Result.error("订单取消失败");
    }

}