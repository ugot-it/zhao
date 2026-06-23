<template>
    <div>
      <NavBar />
      <div class="favorites-container">
        <h1>心动不如行动</h1>
        
        <div v-if="loading" class="loading">加载中...</div>
        
        <div v-else>
          <div v-if="favorites.length === 0" class="empty">
            您还没有收藏任何商品
          </div>
          
          <div v-else class="favorites-list">
            <div v-for="item in favorites" :key="item.id" class="favorite-item">
              <img :src="getImageUrl(item.imageUrl)" class="product-image">
              
              <div class="product-info">
                <h3>{{ item.name }}</h3>
                <div class="price">¥{{ item.price }}</div>
              </div>
              
              <div class="actions">
                <button @click="purchaseProduct(item)" class="purchase-btn">
                  购买
                </button>
                <button @click="removeFavorite(item.id)" class="remove-btn">
                  取消收藏
                </button>
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
  import { useRouter } from 'vue-router'
  
  const router = useRouter()
  const favorites = ref([])
  const loading = ref(true)
  
  // 获取完整图片URL
  const getImageUrl = (relativePath) => {
    if (!relativePath) return ''
    const baseUrl = import.meta.env.VITE_IMAGE_BASE_URL || 'http://localhost:8080/api/image/'
    const filename = relativePath.split('/').pop()
    return `${baseUrl}${filename}`
  }
  
  // 加载收藏列表
  const fetchFavorites = async () => {
    try {
      // 1. 从localStorage获取用户信息
      const userInfo = JSON.parse(localStorage.getItem('userInfo'));
      if (!userInfo || !userInfo.data || !userInfo.data.id) {
        router.push('/login');
        return;
      }
      
      // 2. 使用正确的用户ID路径
      const userId = userInfo.data.id;
      
      // 3. 使用完整的API路径
      const response = await axios.get('/favorite/list', {
        params: {
          userId: userId  // 使用定义好的userId变量
        }
      });
      
      if (response.data.code === 200) {
        // 映射后端返回的数据结构
        favorites.value = response.data.data.map(item => ({
          id: item.productId, // 使用productId作为id，因为前端其他地方可能依赖这个id
          favoriteId: item.id, // 保存收藏记录ID用于取消收藏
          name: item.productName,
          price: item.productPrice,
          imageUrl: item.productImage,
          createTime: item.createTime
        }))
      } else {
        console.error('获取收藏列表失败:', response.data.message)
        alert('获取收藏列表失败: ' + response.data.message)
      }
    } catch (error) {
      console.error('请求失败:', error)
      alert('获取收藏列表失败，请稍后重试')
    }
    finally {
      loading.value = false
    }
  }
  
  const removeFavorite = async (productId) => {
    try {
      const userInfo = JSON.parse(localStorage.getItem('userInfo'));
      if (!userInfo?.data?.id) {
        alert('请先登录');
        return router.push('/login');
      }
      
      await axios.delete(`/favorite/remove?userId=${userInfo.data.id}&productId=${productId}`);
      
      // 更新前端收藏列表
      favorites.value = favorites.value.filter(item => item.id !== productId);
      alert('取消收藏成功');
    } catch {
      alert('取消收藏失败');
    }
  };
  
  // 购买商品
  const purchaseProduct = (product) => {
    // 跳转到商品详情页，传递商品ID
    router.push(`/products/${product.id}`);
  };
  
  onMounted(() => {
    fetchFavorites()
  })
  </script>
  
  <style scoped>
  .favorites-container {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 2rem;
  }
  h1 {
  text-align: center;
  margin-bottom: 2rem;
  color: #f0f1e4;
  }
  .loading, .empty {
    text-align: center;
    padding: 2rem;
    color: #2e3135;
    background: rgba(243, 218, 168, 0.7);
  }
  
  .favorites-list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 2rem;
  }
  
  .favorite-item {
    display: flex;
    flex-direction: column;
    background: rgba(255, 255, 255, 0.8);
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
    overflow: hidden;
  }
  
  .product-image {
    width: 100%;
    height: 200px;
    object-fit: cover;
  }
  
  .product-info {
    padding: 1rem;
  }
  
  .product-info h3 {
    margin: 0 0 0.5rem;
    color: #303133;
  }
  
  .price {
    color: #f56c6c;
    font-weight: bold;
  }
  
  .actions {
    display: flex;
    gap: 1rem;
    padding: 1rem;
    border-top: 1px solid #e4e7ed;
  }
  
  .purchase-btn {
    flex: 1;
    padding: 0.8rem;
    background-color: #409eff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  
  .remove-btn {
    flex: 1;
    padding: 0.8rem;
    background-color: #fef0f0;
    color: #f56c6c;
    border: 1px solid #fde2e2;
    border-radius: 4px;
    cursor: pointer;
  }
  </style>