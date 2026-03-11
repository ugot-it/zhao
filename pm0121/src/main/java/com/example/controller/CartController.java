package com.example.controller;

import com.example.DTO.CartDetailDTO;
import com.example.common.Result;
import com.example.entity.Cart;
import com.example.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;
//记得返回商品的名字和该商品的价格
@GetMapping("/details")
public Result<List<CartDetailDTO>> getCartDetails(
        @RequestParam Long userId) {
    return Result.success(cartService.selectCartDetailsByUserId(userId));
}
    @PostMapping("/item")
    public Result<String> addItem(
            @RequestParam("userId") Long userId,
            @RequestParam("productId") Long productId,
            @RequestParam(value = "quantity", defaultValue = "1") Integer quantity) {
        return cartService.addCartItem(userId, productId, quantity);
    }

    @PutMapping("/item/quantity")
    public Result<String> updateQuantity(
            @RequestParam("userId") Long userId,
            @RequestParam("productId") Long productId,
            @RequestParam("quantity") Integer quantity) {
        return cartService.updateCartItemQuantity(userId, productId, quantity);
    }

    @DeleteMapping("/item")
    public Result<String> removeItem(
            @RequestParam("userId") Long userId,
            @RequestParam("productId") Long productId) {
        return cartService.removeCartItem(userId, productId);
    }

    @DeleteMapping("/clear")
    public Result<String> clearCart(@RequestParam("userId") Long userId) {
        return cartService.clearUserCart(userId);
    }

}