<template>
    <div>
      <navbar />
      <div class="profile-container">
        <h1>修改个人资料</h1>
        
        <form @submit.prevent="updateProfile" class="profile-form">     
          <div class="form-group">
            <label>新用户名</label>
            <input v-model="profile.username" type="text" required>
          </div>
                
          <div class="form-group">
            <label>新密码</label>
            <input v-model="profile.newPassword" type="password" placeholder="留空则不修改">
          </div>
          
          <div class="form-group">
            <label>确认密码</label>
            <input v-model="profile.confirmPassword" type="password">
            <p v-if="passwordMismatch" class="error">两次输入的密码不一致</p>
          </div>
          
          
          <div class="form-group">
            <label>新邮箱</label>
            <input v-model="profile.email" type="email" required>
          </div>
          
          <div class="form-group">
            <label>个性签名：</label>
            <input v-model="profile.address" type="text" required>
          </div>

          <button type="submit" :disabled="isSubmitting" class="submit-btn">
            {{ isSubmitting ? '保存中...' : '保存更改' }}
          </button>
        </form>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, computed, onMounted } from 'vue'
  import navbar from '../../components/NavBar.vue'
  import axios from 'axios'
  
  const profile = ref({
    username: '',
    email: '',
    address: '',
    newPassword: '',
    confirmPassword: ''
  })
  
  const isSubmitting = ref(false)
  
  const passwordMismatch = computed(() => {
    return profile.value.newPassword && 
           profile.value.newPassword !== profile.value.confirmPassword
  })
  
  const loadUserProfile = async () => {
    try {
      const userInfo = JSON.parse(localStorage.getItem('userInfo'))
      if (userInfo && userInfo.id) {
        profile.value.id = userInfo.id
        profile.value.username = userInfo.username || ''
        profile.value.email = userInfo.email || ''
        profile.value.address = userInfo.address || ''
       
      }
      
    } catch (error) {
      console.error('加载用户信息失败:', error)
    }
  }
  
  const updateProfile = async () => {
    if (passwordMismatch.value) {
      alert('两次输入的密码不一致')
      return
    }
  
    try {
      isSubmitting.value = true
      const userInfo = JSON.parse(localStorage.getItem('userInfo'))
      console.log(userInfo.data.id)
      const response = await axios.post('http://localhost:8080/api/admin/updateUser', {
        id:  userInfo.data.id,
        username: profile.value.username,
        email: profile.value.email,
        address: profile.value.address,
        password: profile.value.newPassword || undefined
      })
      
      if (response.data.code === 200) {
        alert('个人资料更新成功')
        // 更新本地存储的用户信息
        const userInfo = JSON.parse(localStorage.getItem('userInfo')) || {}
        userInfo.username = profile.value.username
        userInfo.email = profile.value.email
        userInfo.address = profile.value.address
        localStorage.setItem('userInfo', JSON.stringify(userInfo))
        
 
      } else {
        alert(`更新失败: ${response.data}`)
      }
    } catch (error) {
      console.error('更新失败:', error)
      alert('更新失败，请稍后重试')
    } finally {
      isSubmitting.value = false
    }
  }
  
  onMounted(() => {
    loadUserProfile()
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
  
  .profile-form {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
  }
  
  .form-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
  
  label {
    font-weight: 500;

  }
  
  input {
    padding: 0.8rem;
    border: 1px solid #dcdfe6;
    border-radius: 4px;
    font-size: 1rem;
  }
  
  .error {
    color: #f56c6c;
    font-size: 0.9rem;
    margin-top: 0.3rem;
  }
  
  .submit-btn {
    padding: 0.8rem;
    background-color: #6a705b;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    transition: background-color 0.3s;
  }
  
  .submit-btn:disabled {
    background-color: #a0cfff;
    cursor: not-allowed;
  }
  </style>