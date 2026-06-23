<template>
  <navbar />
  <div class="product-detail-container">
    <div v-if="loading" class="loading">加载中...</div>
    <div v-else class="product-detail">
      <div class="product-images">
        <img
          v-if="product.imageUrl"
          :src="getProductImageUrl(product.imageUrl)"
          :alt="product.name"
          class="main-image"
          @error="handleImageError"
        />
        <div v-else class="image-placeholder">暂无图片</div>
      </div>
      <div class="product-info">
        <h1 class="product-title">{{ product.name }}</h1>
        <div class="product-price">¥{{ product.price }}</div>
        <div class="product-stock">库存: {{ product.stock }}</div>
        <div class="product-status">
          <span
            :class="[
              'status-badge',
              product.status === 1 ? 'on-sale' : 'off-sale',
            ]"
          >
            {{ product.status === 1 ? "在售" : "已下架" }}
          </span>
        </div>
        <div class="product-description">
          <h3>商品描述</h3>
          <p>{{ product.description }}</p>
        </div>
        <div class="product-actions">
          <div class="quantity-selector">
            <button @click="decreaseQuantity" class="quantity-btn">-</button>
            <input 
              type="number" 
              v-model.number="quantity" 
              min="1" 
              :max="product.stock"
              class="quantity-input"
            >
            <button @click="increaseQuantity" class="quantity-btn">+</button>
          </div>
          
          <button
            v-if="product.status === 1"
            @click="purchaseProduct"
            class="purchase-btn"
          >
            立即购买
          </button>
          
          <!-- 添加购物车按钮 -->
          <button 
            v-if="product.status === 1"
            @click="addToCart" 
            class="cart-btn"
            :disabled="isCartLoading"
          >
            加入购物车
          </button>
          
          <!-- 添加收藏按钮 -->
          <button 
            @click="addToFavorites" 
            class="favorite-btn"
            :disabled="isFavoriteLoading"
          >
            {{ isFavorite ? '已收藏' : '收藏' }}
          </button>

          <button class="back-btn" @click="goBack">返回列表</button>
        </div>
      </div>
    </div>
  </div>
  <div v-if="showPaymentDialog" class="payment-dialog">
    <div class="dialog-content">
      <p>已成功下单，是否立刻支付？</p>
      <div class="dialog-actions">
        <button @click="confirmPayment" class="confirm-btn">支付</button>
        <button @click="cancelPayment" class="cancel-btn">取消</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import axios from "axios";
import navbar from "../../components/NavBar.vue";



const route = useRoute();
const router = useRouter();
const product = ref({});
const loading = ref(true);
const isFavorite = ref(false);
const isFavoriteLoading = ref(false);
const isCartLoading = ref(false);

// 配置后端图片基础URL
const BASE_IMAGE_URL =
  import.meta.env.VITE_IMAGE_BASE_URL || "http://localhost:8080/api/image/";

// 获取完整图片URL
const getProductImageUrl = (relativePath) => {
  if (!relativePath) return "";
  const filename = relativePath.split("/").pop();
  return `${BASE_IMAGE_URL}${filename}`;
};

// 图片加载失败处理
const handleImageError = (event) => {
  event.target.style.display = "none";
  const placeholder = document.createElement("div");
  placeholder.className = "image-placeholder";
  placeholder.textContent = "图片加载失败";
  event.target.parentNode.insertBefore(placeholder, event.target.nextSibling);
};

// 获取商品详情
const fetchProductDetail = async () => {
  try {
    const response = await axios.get(`/products/${route.params.id}`);
    if (response.data.code === 200) {
      product.value = response.data.data;



    } else {
      console.error("获取商品详情失败:", response.data.message);
    }
  } catch (error) {
    console.error("请求失败:", error);
    alert("获取商品详情失败，请稍后重试");
  } finally {
    loading.value = false;
  }
};

const showPaymentDialog = ref(false);

// 购买商品
const currentOrderId = ref(null); // 新增一个ref来存储订单ID

const purchaseProduct = async () => {
  try {
    // 检查商品库存
    if (product.value.stock < quantity.value) {
      alert(`库存不足，当前库存: ${product.value.stock}`);
      return;
    }
    
    // 获取本地存储的收货信息
    const shippingAddress = JSON.parse(localStorage.getItem('shippingAddress'));
    if (!shippingAddress) {
      alert('请先填写收货信息');
      return router.push('/address');
    }
    
    // 创建订单
    const userInfo = JSON.parse(localStorage.getItem('userInfo'));
    if (!userInfo?.data?.id) {
      alert('请先登录');
      return router.push('/login');
    }
    
    const response = await axios.post(
      `http://localhost:8080/api/order/create?userId=${userInfo.data.id}&productId=${product.value.id}&quantity=${quantity.value}&address=${encodeURIComponent(shippingAddress.address)}&receiverName=${encodeURIComponent(shippingAddress.receiverName)}&receiverPhone=${encodeURIComponent(shippingAddress.receiverPhone)}`
    );
    
    if (response.data.code === 200) {
      currentOrderId.value = response.data.data.orderId;
      product.value.stock -= quantity.value;
      alert(`订单创建成功！\n订单ID: ${currentOrderId.value}\n请及时完成支付`);
      showPaymentDialog.value = true;
    } else {
      alert('订单创建失败: ' + response.data.message);
    }
  } catch (error) {
    console.error('购买商品失败:', error);
    alert('购买商品失败，请稍后重试');
  }
};

const confirmPayment = async () => {
  try {
    const userInfo = JSON.parse(localStorage.getItem('userInfo'));
    if (!userInfo?.data?.id) {
      alert('请先登录');
      return router.push('/login');
    }
    
    // 使用保存的订单ID
    const response = await axios.post(
      `http://localhost:8080/api/payment/pay?orderId=${currentOrderId.value}&userId=${userInfo.data.id}`
    );
    
    if (response.data.code === 200) {
      alert('支付成功，请静候佳音');
      router.push('/orders');
    } else {
      alert('支付失败: ' + response.data.message);
    }
  } catch (error) {
    console.error('支付请求失败:', error);
    alert('支付请求失败，请稍后重试');
  } finally {
    showPaymentDialog.value = false;
  }
};

// 取消支付
const cancelPayment = async () => {
  showPaymentDialog.value = false;
};

// 加入购物车
const addToCart = async () => {
  try {
    isCartLoading.value = true;
    
    const userInfo = JSON.parse(localStorage.getItem('userInfo'));
    if (!userInfo?.data?.id) {
      alert('请先登录');
      return router.push('/login');
    }
    
    const response = await axios.post(
      `http://localhost:8080/api/cart/item?userId=${userInfo.data.id}&productId=${product.value.id}&quantity=${quantity.value}`
    );
    
    if (response.data.code === 200) {
      alert('商品已成功加入购物车');
    } else {
      alert('加入购物车失败: ' + response.data.message);
    }
  } catch (error) {
    console.error('加入购物车失败:', error);
    alert('加入购物车失败，请稍后重试');
  } finally {
    isCartLoading.value = false;
  }
};

// 返回商品列表
const goBack = () => {
  router.push("/products");
};



// 添加收藏
const addToFavorites = async () => {
  try {
    isFavoriteLoading.value = true;
    
    // 修改用户信息获取方式
    const userInfo = JSON.parse(localStorage.getItem('userInfo'));
    if (!userInfo || !userInfo.data || !userInfo.data.id) {
      alert('请先登录');
      return router.push('/login');
    }
    
    const userId = userInfo.data.id; // 正确的用户ID路径
    
    const response = await axios.post(
      `/favorite/add?userId=${userId}&productId=${product.value.id}`
     
    );
    
    if (response.data.code === 200) {
      isFavorite.value = true;
      alert('收藏成功');
    } else {
      alert('都收藏过了还收藏，你想干嘛');
    }
  } catch (error) {
    console.error('收藏失败:', error);
    alert('收藏失败，请稍后重试');
  } finally {
    isFavoriteLoading.value = false;
  }
};

// 在获取商品详情后检查收藏状态
onMounted(async () => {
  await fetchProductDetail();

});
const quantity = ref(1); // 添加数量选择

// 增加数量
const increaseQuantity = () => {
  if (quantity.value < product.value.stock) {
    quantity.value++;
  }else{
    alert("不可超过库存")
  }
};

// 减少数量
const decreaseQuantity = () => {
  if (quantity.value > 1) {
    quantity.value--;
  }else{
    alert("以达到最小购买数")
  }
};
</script>

<style scoped>
.product-detail-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
}

.loading {
  text-align: center;
  padding: 2rem;
  color: #666;
}

.product-detail {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  background: white;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.product-images {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  align-items: center;
}
.product-images img {
  width: min(100%, 200px); /* 响应式但不超过250px */
  height: auto;
}

.main-image {
  width: 100%;
  height: auto;
  border-radius: 8px;
}

.product-info {
  display: flex;
  flex-direction: column;
}

.product-title {
  font-size: 1.8rem;
  margin: 0 0 1rem;
  color: #303133;
}

.product-price {
  font-size: 1.5rem;
  color: #f56c6c;
  font-weight: bold;
  margin-bottom: 1rem;
}

.product-stock {
  color: #606266;
  margin-bottom: 1rem;
}

.status-badge {
  display: inline-block;
  padding: 0.3rem 0.8rem;
  border-radius: 4px;
  font-size: 0.9rem;
  margin-bottom: 1.5rem;
}

.on-sale {
  background-color: #f0f9eb;
  color: #67c23a;
}

.off-sale {
  background-color: #fef0f0;
  color: #f56c6c;
}

.product-description h3 {
  margin: 1.5rem 0 0.8rem;
  color: #303133;
}

.product-description p {
  color: #606266;
  line-height: 1.6;
}

.product-actions {
  margin-top: 2rem;
  display: flex;
  gap: 1rem;
}

.purchase-btn {
  padding: 0.8rem 2rem;
    background: linear-gradient(145deg, #1f1f1f, #292929);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.purchase-btn:hover {
  background-color: #66b1ff;
}

.back-btn {
  padding: 0.8rem 2rem;
  background-color: #909399;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.back-btn:hover {
  background-color: #a6a9ad;
}

.image-placeholder {
  width: 100%;
  height: 300px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f5f7fa;
  color: #909399;
  border-radius: 8px;
}

/* 添加收藏按钮样式 */
.cart-btn {
  padding: 0.8rem 1.5rem;
  background-color: #ecf5ff;
  color: #409eff;
  border: 1px solid #d9ecff;
  border-radius: 4px;
  cursor: pointer;
}

.cart-btn:hover {
  background-color: #d9ecff;
}

.favorite-btn {
  padding: 0.8rem 1.5rem;
  background-color: #f0f9eb;
  color: #67c23a;
  border: 1px solid #e1f3d8;
  border-radius: 4px;
  cursor: pointer;
}

.favorite-btn:hover {
  background-color: #e1f3d8;
}

.favorite-btn:disabled {
  background-color: #bdbdbd;
  cursor: not-allowed;
}
.quantity-selector {
  display: flex;
  align-items: center;
  margin-right: 1rem;
}

.quantity-btn {
  width: 30px;
  height: 30px;
  background-color: #f5f7fa;
  border: 1px solid #dcdfe6;
  cursor: pointer;
}

.quantity-input {
  width: 50px;
  height: 30px;
  text-align: center;
  margin: 0 5px;
  border: 1px solid #dcdfe6;
}
</style>


<style scoped>
.payment-dialog {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.dialog-content {
  background: white;
  padding: 2rem;
  border-radius: 8px;
  width: 300px;
  text-align: center;
}

.dialog-actions {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-top: 1.5rem;
}

.confirm-btn {
  padding: 0.5rem 1rem;
  background-color: #409eff;
  color: white;
  border: none;
  border-radius: 4px;
}

.cancel-btn {
  padding: 0.5rem 1rem;
  background-color: #f56c6c;
  color: white;
  border: none;
  border-radius: 4px;
}
</style>
