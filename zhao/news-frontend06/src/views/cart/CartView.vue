<template>
  <div>
    <NavBar />
    <div class="cart-container">
      <div v-if="loading" class="loading">加载中...</div>

      <div v-else class="cart-content">
        <h1>您希望我们为您做什么？</h1>

        <div v-if="cartItems.length === 0" class="empty-cart">
          <p>您可以向我们诉说任何想法</p>
          <button @click="goToProducts" class="shop-btn">去逛逛</button>
        </div>

        <div v-else>
      
          
          <div class="cart-items">
            <div v-for="item in cartItems" :key="item.id" class="cart-item">
              <div class="item-info">

                <div class="product-details">
                  <h3>{{ item.productName }}</h3>
                  <p>单价: ¥</p>
                  <h3>{{ item.productPrice }}</h3>
              
                </div>
              </div>

              <div class="quantity-control">
                <button
                  @click="decreaseQuantity(item)"
                  :disabled="item.quantity <= 1"
                >
                  -
                </button>
                <span>{{ item.quantity }}</span>
                <button @click="increaseQuantity(item)">+</button>
              </div>

              <div class="item-total">
                <h3>小计：¥{{ item.subtotal }}</h3>
              </div>

              <button @click="removeItem(item)" class="remove-btn">删除</button>
            </div>
          </div>

          <div class="cart-summary">
            <div class="total-row">
              <span>总计:</span>
              <span>¥{{ totalAmount.toFixed(2) }}</span>
            </div>
            <button @click="checkout" class="checkout-btn">结算</button>
          </div>
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

import { ref, onMounted, computed } from "vue";
import { useRouter } from "vue-router";
import NavBar from "../../components/NavBar.vue";
import axios from "axios";
import { useStore } from 'vuex';

const router = useRouter();
const cartItems = ref([]);
const store = useStore(); 
const loading = ref(true);
const product = ref({});
const quantity = ref(1);

  // 从本地存储获取userId
  const userInfo = JSON.parse(localStorage.getItem("userInfo"));
  const userId = userInfo.data.id;
  const showPaymentDialog = ref(false);
  const currentOrderId = ref(null);
 
// 获取购物车数据
const fetchCartItems = async () => {


  try {
    const response = await axios.get(
      `cart/details?userId=${userId}`
    );

    if (response.data.code === 200) {
      cartItems.value = response.data.data;
      console.log('当前商品:', cartItems.value);
    } else {
      console.error("获取购物车失败:", response.data.message);
    }
  } catch (error) {
    console.error("请求失败:", error);
    alert("获取购物车失败，请稍后重试");
  } finally {
    loading.value = false;
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
      alert('支付成功，一场奇妙之旅即将到来');
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



// 增加商品数量

const increaseQuantity = async (item) => {
  const maxStock = store.getters.getProductStock(item.productId);
  if (item.quantity < maxStock) {
    item.quantity++;
    item.subtotal = item.productPrice * item.quantity; // 新增这行
    await updateCartItem(item);
  } else {
    alert(`库存不足，最大可购买数量: ${maxStock}`);
  }
};

const decreaseQuantity = async (item) => {
  if (item.quantity > 1) {
    item.quantity--;
    item.subtotal = item.productPrice * item.quantity; // 新增这行
    await updateCartItem(item);
  }
};

// 更新购物车商品
const updateCartItem = async (item) => {
  try {
    await axios.put(`cart/item/quantity?userId=${userId}&productId=${item.productId}&quantity=${item.quantity}`, {
      user_id: userId,
      product_id: item.productId,
      quantity: item.quantity,
    });
  } catch (error) {
    console.error("更新购物车失败:", error);
    alert("更新购物车失败，请稍后重试");
  }
};

// 移除商品
const removeItem = async (item) => {
  if (!confirm("确定要从购物车移除该商品吗？")) return;

  try {
    await axios.delete(
      `cart/item?userId=${userId}&productId=${item.productId}`
    );
    cartItems.value = cartItems.value.filter((i) => i.id !== item.id);
  } catch (error) {
    console.error("移除商品失败:", error);
    alert("移除商品失败，请稍后重试");
  }
};

// 在计算属性中添加总价计算
const totalAmount = computed(() => {
  return cartItems.value.reduce(
    (total, item) => total + item.subtotal,0
  );
});

// 结算
const checkout = async () => {
  if (!confirm('确定要结算购物车中的所有商品吗？')) return;
  
  try {
    const userInfo = JSON.parse(localStorage.getItem('userInfo'));
    const userId = userInfo.data.id;
    
    // 获取收货地址
    const shippingAddress = JSON.parse(localStorage.getItem('shippingAddress'));
    if (!shippingAddress) {
      alert('请先填写收货信息');
      return router.push('/address');
    }
    
    // 构建商品参数
    const productsParam = cartItems.value
      .map(item => `productId=${item.productId}&quantity=${item.quantity}`)
      .join('&');
    
    // 创建订单
    const response = await axios.post(
      `order/create?userId=${userId}&${productsParam}&address=${encodeURIComponent(shippingAddress.address)}&receiverName=${encodeURIComponent(shippingAddress.receiverName)}&receiverPhone=${encodeURIComponent(shippingAddress.receiverPhone)}`
    );
    
    if (response.data.code === 200) {

     
      currentOrderId.value = response.data.data.orderId;
      product.value.stock -= quantity.value;
      alert(`订单创建成功！\n订单ID: ${currentOrderId.value}\n请及时完成支付`);
      showPaymentDialog.value = true;
      // 清空购物车
      await axios.delete(`cart/clear?userId=${userId}`);
      cartItems.value = [];
      
    } else {
      alert('订单创建失败: ' + response.data.message);
    }
  } catch (error) {
    console.error('结算失败:', error);
    alert('结算失败，请稍后重试');
  }
};

// 去商品列表
const goToProducts = () => {
  router.push("/products");
};

onMounted(() => {
  fetchCartItems();
 
});
</script>

<style scoped>
.cart-container {
  margin: 2rem auto;
  padding: 0 2rem;
  max-width: 1200px;
}

.loading {
  text-align: center;
  padding: 2rem;
  color: #606266;
}



.empty-cart {
  background: rgba(243, 218, 168, 0.7);
  text-align: center;
  padding: 2rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1.5rem;
  color: #2e3135;
  
}

h1 {
  margin: 0 0 2rem 0;
  color: #303133;
  padding-bottom: 1rem;
  text-align: left;
}

.shop-btn {
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #186c46;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.cart-items {
  background:  rgba(235, 233, 197, 0.8);
  box-shadow: 0 0 30px #000000aa;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  overflow: hidden;

  
}

.favorite-items {
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: rgba(235, 233, 197, 0.5);
  border-radius: 8px;
}

.favorite-item {
  padding: 1rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #eee;
}

.cart-item {
  padding: 1.5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

h1 {
  text-align: center;
  margin-bottom: 2rem;
  color: #f0f1e4;
}
.item-info {
  display: flex;
  align-items: center;
  flex: 2;
}

.product-image {
  width: 80px;
  height: 80px;
  object-fit: cover;
  margin-right: 20px;
}

.product-details {
  /* flex: 1; */
  padding: 1.5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;

}

.quantity-control {
  display: flex;
  align-items: center;
  flex: 1;
  justify-content: center;
}

.quantity-control button {
  width: 30px;
  height: 30px;
  border: 1px solid #ddd;
  background-color: white;
  cursor: pointer;
}

.quantity-control span {
  margin: 0 10px;
  min-width: 20px;
  text-align: center;
}

.item-total {
  flex: 1;
  text-align: right;
}

.remove-btn {
  background-color: #ff4d4f;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.9rem;
}

.cart-summary {
  margin-top: 30px;
  padding: 20px;
  margin-bottom: 2rem;
  color: #f0f1e4;
  border-radius: 4px;
  text-align: center;
}

.total-row {
  margin-bottom: 20px;
  font-size: 18px;
  font-weight: bold;
}

.checkout-btn {
  padding: 10px 30px;
  background-color: #d06e2d;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
}

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
  background-color: #7d4411;
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