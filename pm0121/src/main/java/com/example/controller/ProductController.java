package com.example.controller;

import com.example.common.Result;
import com.example.entity.Product;
import com.example.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    // 商品上架接口
    @PostMapping("/list/{productId}")
    public Result<String> listProduct(@PathVariable Long productId) {
        return productService.listProduct(productId);
    }
    // 商品搜索接口
    @GetMapping("/search")
    public Result<List<Product>> searchProducts(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Long categoryId) {
        return productService.searchProducts(keyword, categoryId);
    }

    // 库存调整接口
    @PostMapping("/stock/{productId}")
    public Result<String> updateStock(
            @PathVariable Long productId,
            @RequestParam Integer quantity) {
        return productService.updateStock(productId, quantity);
    }

    // 商品详情接口
    @GetMapping("/{id}")
    public Result<Product> getProductById(@PathVariable Long id) {
        return productService.getProductById(id);
    }
}