package com.example.service;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.entity.Product;
import com.example.common.Result;

import java.util.List;


public interface ProductService  extends IService<Product> {

        // 商品上架
        Result<String> listProduct(Long productId);

        // 商品搜索
        Result<List<Product>> searchProducts(String keyword, Long categoryId);

        // 库存调整
        Result<String> updateStock(Long productId, Integer quantity);

        // 商品详情
        Result<Product> getProductById(Long id); // 注意参数类型统一为Long

}

