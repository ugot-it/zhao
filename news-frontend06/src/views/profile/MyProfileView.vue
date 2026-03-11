<template>
  <div>
    <navbar />
    <div class="profile-container">
      <h1>个人主页</h1>
      
      <div class="profile-info">
        <div class="info-item">
          <span class="info-label">用户ID:</span>
          <span class="info-value">{{ user.id }}</span>
        </div>
        
        <div class="info-item">
          <span class="info-label">用户名:</span>
          <span class="info-value">{{ user.username }}</span>
        </div>
        
        <div class="info-item">
          <span class="info-label">邮箱:</span>
          <span class="info-value">{{ user.email || '未设置' }}</span>
        </div>
        
        <div class="info-item">
          <span class="info-label">密码:</span>
          <span class="info-value">********</span>
        </div>
        
        <div class="info-item">
          <span class="info-label">个性签名:</span>
          <span class="info-value">{{ user.address || '未设置' }}</span>
        </div>
      </div>
      
      <button @click="goToEditProfile" class="edit-btn">
        修改资料
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import navbar from '../../components/NavBar.vue'
import axios from 'axios'

const router = useRouter()
const user = ref({
  id: '',
  username: '',
  email: '',
  password: '',
  address: ''
})

// 获取用户信息
const fetchUserProfile = async () => {
  try {
    const userInfoString = localStorage.getItem('userInfo')
    if (!userInfoString) {
      router.push('/login')
      return
    }
    
    const userInfo = JSON.parse(userInfoString)
    const userId = userInfo.data?.id || userInfo.id
    
    const response = await axios.get('http://localhost:8080/api/admin/getUserInfo', {
      params: { userId }
    })
    
    if (response.data.code === 200) {
      user.value = response.data.data
    } else {
      alert(response.data.message)
    }
  } catch (error) {
    console.error('获取用户信息失败:', error)
    alert('获取用户信息失败，请稍后重试')
  }
}

// 跳转到编辑页面
const goToEditProfile = () => {
  router.push('/profile')
}

// 组件挂载时获取用户信息
onMounted(() => {
  fetchUserProfile()
})
</script>

<style scoped>
.profile-container {
  max-width: 600px;
  margin: 2rem auto;
  padding: 2rem;

  background: rgba(255, 255, 255, 0.7);
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

h1 {
  text-align: center;
  margin-bottom: 2rem;
  color: #303133;
}

.profile-info {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.info-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.8rem;
  border-bottom: 1px solid #ebeef5;
}

.info-label {
  font-weight: 500;

  min-width: 100px;
}

.info-value {
  flex: 1;
  padding: 0.5rem 0;
}

.edit-btn {
  padding: 0.8rem;
  width: 100%;
  background-color: #6a705b;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 1rem;
  transition: background-color 0.3s;
}

.edit-btn:hover {
  background-color: #6a705b;
}
</style>