<template>
  <div>
    <NavBar />
    <div class="orders-container">
      <h1>我的订单</h1>
      
      <div v-if="loading" class="loading">加载中...</div>
      <div v-else>
        <div v-if="orders.length === 0" class="no-orders">
          您还没有任何订单
        </div>
        
        <div v-else class="orders-list">
          <div v-for="order in orders" :key="order.id" class="order-card">
            <div class="order-header">
              <span class="order-id">订单号: {{ order.id }}</span>
              <span :class="['status', getStatusClass(order.status)]">
                {{ getStatusText(order.status) }}
              </span>
            </div>
            
            <div class="order-body">
              <div class="order-info">
                <p>总金额: ¥{{ order.totalAmount }}</p>
                <p>收货地址: {{ order.address }}</p>
                <p>创建时间: {{ formatDate(order.createTime) }}</p>
              </div>
              
              <div class="order-actions">

                <router-link 
                  :to="`/orders/${order.id}`"
                  class="detail-btn"
                >
                  查看详情
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import NavBar from '../../components/NavBar.vue'
import axios from 'axios'

const orders = ref([])
const loading = ref(true)

// 获取订单列表
const fetchOrders = async () => {
  try {
   const userInfoString = localStorage.getItem('userInfo');
   const userInfo = JSON.parse(userInfoString);
    const userId = userInfo.data.id;
    loading.value = true
    const response = await axios.get(`/order/list`,{
      params: {
        userId: userId
      }
    });
    
    if (response.data.code === 200) {
      orders.value = response.data.data.records
    } else {
      console.error('获取订单失败:', response.data.message)
    }
  } catch (error) {
    console.error('请求失败:', error)
    alert('获取订单失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

// 取消订单
const cancelOrder = async (orderId) => {
  if (!confirm('确定要取消此订单吗？')) return
  
  try {
    const response = await axios.post(`/order/cancel/${orderId}`)
    
    if (response.data.code === 200) {
      alert('订单已取消')
      fetchOrders() // 刷新列表
    } else {
      alert(`取消订单失败: ${response.data.message}`)
    }
  } catch (error) {
    console.error('取消订单失败:', error)
    alert('取消订单失败，请稍后重试')
  }
}



// 格式化日期
const formatDate = (dateString) => {
  return new Date(dateString).toLocaleString('zh-CN')
}

// 获取订单状态文本
const getStatusText = (status) => {
  const statusMap = {
    0: '未支付',
    1: '已支付',
    2: '已发货',
    3: '已完成',
    4: '已取消',
  }
  return statusMap[status] || '未知状态'
}

// 获取订单状态对应的CSS类
const getStatusClass = (status) => {
  const classMap = {
    0: 'cancelled',
    1: 'pending',
    2: 'shipped',
    3: 'completed'
  }
  return classMap[status] || ''
}

onMounted(() => {
  fetchOrders()
})
</script>

<style scoped>
.orders-container {
  max-width: 1000px;
  margin: 2rem auto;
  padding: 0 2rem;
}

h1 {
  text-align: center;
  margin-bottom: 2rem;
  color: #f0f1e4;
}

.loading, .no-orders {
  text-align: center;
  padding: 2rem;
  color: #606266;
}

.orders-list {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.order-card {
  background:  rgba(235, 233, 197, 0.8);
  box-shadow: 0 0 30px #000000aa;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1.5rem;
  background: #f5f7fa;
  border-bottom: 1px solid #e4e7ed;
}

.order-id {
  font-weight: 500;
}

.status {
  padding: 0.3rem 0.8rem;
  border-radius: 4px;
  font-size: 0.9rem;
}

.status.pending {
  background-color: #fdf6ec;
  color: #e6a23c;
}

.status.shipped {
  background-color: #f0f9eb;
  color: #67c23a;
}

.status.completed {
  background-color: #e1f3d8;
  color: #529b2e;
}

.status.cancelled {
  background-color: #fef0f0;
  color: #f56c6c;
}

.order-body {
  padding: 1.5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.order-info {
  flex: 1;
}

.order-info p {
  margin: 0.5rem 0;
  color: #606266;
}

.order-actions {
  display: flex;
  gap: 1rem;
}

.cancel-btn, .delete-btn, .detail-btn {
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.9rem;
}

.cancel-btn {
  background-color: #fef0f0;
  color: #f56c6c;
  border: 1px solid #fde2e2;
}

.cancel-btn:hover {
  background-color: #fde2e2;
}

.delete-btn {
  background-color: #fef0f0;
  color: #f56c6c;
  border: 1px solid #fde2e2;
}

.delete-btn:hover {
  background-color: #fde2e2;
}

.detail-btn {
  background-color: #ecf5ff;
  color: #409eff;
  border: 1px solid #d9ecff;
  text-decoration: none;
}

.detail-btn:hover {
  background-color: #d9ecff;
}
</style>