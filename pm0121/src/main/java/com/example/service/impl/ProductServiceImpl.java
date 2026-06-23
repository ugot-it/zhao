package com.example.service.impl;import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.common.Result;
import com.example.entity.Product;
import com.example.mapper.ProductMapper;
import com.example.service.ProductService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class ProductServiceImpl
        extends ServiceImpl<ProductMapper, Product>
        implements ProductService {

    private static final String PRODUCT_CACHE_PREFIX = "product:";

    // 商品上架
    @Override
    public Result<String> listProduct(Long productId) {
        Product product = this.getById(productId);
        if (product == null) {
            return Result.error("商品不存在");
        }
        product.setStatus(1); // 1表示上架
        this.updateById(product);
        return Result.success("商品上架成功");
    }

    // 商品搜索
    @Override
    public Result<List<Product>> searchProducts(String keyword, Long categoryId) {
        QueryWrapper<Product> wrapper = new QueryWrapper<>();

        // 按商品名称模糊查询
        if (StringUtils.isNotBlank(keyword)) {
            wrapper.like("name", keyword);
        }

        // 按分类ID精确查询
        if (categoryId != null) {
            wrapper.eq("category_id", categoryId);
        }

        return Result.success(this.list(wrapper));
    }

    // 库存调整
    @Override
    public Result<String> updateStock(Long productId, Integer quantity) {
        if (quantity < 0) {
            return Result.error("调整数量不能为负数");
        }

        Product product = this.getById(productId);
        if (product == null) {
            return Result.error("商品不存在");
        }

        // 计算新库存（确保不低于0）
        int newStock = Math.max(product.getStock() + quantity, 0);
        product.setStock(newStock);
        this.updateById(product);

        return Result.success("库存调整成功，当前库存: " + newStock);
    }

    // 商品详情
    @Override
    public Result<Product> getProductById(Long id) {
     Product product = this.getById(id);
        if (product == null) {
            return Result.error("商品不存在");
        }
        return Result.success(product);
        /*String cacheKey = PRODUCT_CACHE_PREFIX + id;

        // 1. 先查缓存
        Product product = (Product) redisTemplate.opsForValue().get(cacheKey);
        if (product != null) {
            return Result.success(product);
        }

        // 2. 缓存不存在则查数据库
        product = this.getById(id);
        if (product != null) {
            // 3. 写入缓存（设置30分钟过期）
            redisTemplate.opsForValue().set(
                    cacheKey,
                    product,
                    30, TimeUnit.MINUTES
            );
            return Result.success(product);
        }
        return Result.error("商品不存在");
*/
    }
}


