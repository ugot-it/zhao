<template>
    <div>
      <NavBar />
      <div class="order-detail-container">
        <div v-if="loading" class="loading">加载中...</div>
        
        <div v-else class="order-detail">
          <div class="order-header">
            <h1>订单详情</h1>
            <span :class="['status', getStatusClass(order.status)]">
              {{ getStatusText(order.status) }}
            </span>
          </div>
          
          <div class="order-info">
            <div class="info-row">
              <span class="label">订单编号:</span>
              <span class="value">{{ order.id }}</span>
            </div>


            
            <div class="info-row">
              <span class="label">总金额:</span>
              <span class="value">¥{{ order.totalAmount }}</span>
            </div>
            
            <div class="info-row">
              <span class="label">收货地址:</span>
              <span class="value">{{ order.address }}</span>
            </div>
            
            <div class="info-row">
              <span class="label">创建时间:</span>
              <span class="value">{{ formatDate(order.createTime) }}</span>
            </div>
            
            <div class="info-row">
              <span class="label">更新时间:</span>
              <span class="value">{{ formatDate(order.updateTime) }}</span>
            </div>
          </div>
          
          <div class="actions">
            <button 
              v-if="order.status === 0" 
              @click="cancelOrder"
              class="cancel-btn"
            >
              取消订单
            </button>
            <button @click="goBack" class="back-btn">
              返回订单列表
            </button>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import NavBar from '../../components/NavBar.vue'
  import axios from 'axios'
  
  const route = useRoute()
  const router = useRouter()
  const order = ref({})
  const loading = ref(true)
  
  // 获取订单详情
  const fetchOrderDetail = async () => {
    try {
      const response = await axios.get(`/order/${route.params.orderId}`)
      
      if (response.data.code === 200) {
        order.value = response.data.data
      } else {
        console.error('获取订单详情失败:', response.data.message)
      }
    } catch (error) {
      console.error('请求失败:', error)
      alert('获取订单详情失败，请稍后重试')
    } finally {
      loading.value = false
    }
  }
  
  // 取消订单
  const cancelOrder = async () => {
    if (!confirm('确定要取消此订单吗？')) return
    
    try {
      const response = await axios.post(`/order/cancel/${order.value.id}`)
      
      if (response.data.code === 200) {
        alert('订单已取消')
        fetchOrderDetail() // 刷新详情
      } else {
        alert(`取消订单失败: ${response.data.message}`)
      }
    } catch (error) {
      console.error('取消订单失败:', error)
      alert('取消订单失败，请稍后重试')
    }
  }
  
  // 返回订单列表
  const goBack = () => {
    router.push('/orders')
  }
  
  // 格式化日期
  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleString('zh-CN')
  }
  
  // 获取订单状态文本
  const getStatusText = (status) => {
    const statusMap = {
      0: '待支付，请尽快支付哦',
      1: '已支付，请静候佳音',
      2: '已发货，奇妙之旅即将到来',
      3: '已完成，欢迎下次光临',
      4: '已取消，如有需要请重新购买'
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
    fetchOrderDetail()
  })
  </script>
  
  <style scoped>
  .order-detail-container {
    max-width: 800px;
    margin: 2rem auto;
    padding: 0 2rem;
  }
  
  .loading {
    text-align: center;
    padding: 2rem;
    color: #606266;
  }
  
  .order-detail {
    background: rgba(255, 255, 255, 0.8);
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
    padding: 2rem;
  }
  
  .order-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid #e4e7ed;
  }
  
  h1 {
    margin: 0;
    color: #303133;
  }
  
  .status {
    padding: 0.5rem 1rem;
    border-radius: 4px;
    font-weight: 500;
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
  
  .order-info {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    margin-bottom: 2rem;
  }
  
  .info-row {
    display: flex;
  }
  
  .label {
    width: 120px;
    color: #050a15;
    font-weight: 500;
  }
  
  .value {
    flex: 1;
    color: #606266;
  }
  
  .actions {
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
    padding-top: 2rem;
    border-top: 1px solid #e4e7ed;
  }
  
  .cancel-btn {
    padding: 0.8rem 1.5rem;
    background-color: #fef0f0;
    color: #f56c6c;
    border: 1px solid #fde2e2;
    border-radius: 4px;
    cursor: pointer;
  }
  
  .cancel-btn:hover {
    background-color: #fde2e2;
  }
  
  .back-btn {
    padding: 0.8rem 1.5rem;
    background-color: #ecf5ff;
    color: #409eff;
    border: 1px solid #d9ecff;
    border-radius: 4px;
    cursor: pointer;
  }
  
  .back-btn:hover {
    background-color: #d9ecff;
  }
  </style>