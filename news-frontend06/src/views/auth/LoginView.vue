<template>
    <div class="auth-container">
      <div class="form-wrapper">
        <h2>欢迎光临</h2>
        
        <form @submit.prevent="handleLogin">
          <div class="form-group">
            <label>用户名</label>
            <input 
              v-model="form.username" 
              type="text" 
              required
              placeholder="请输入您的账号"
            >
          </div>
          
          <div class="form-group">
            <label>密码</label>
            <input 
              v-model="form.password" 
              type="password" 
              required
              placeholder="请输入密码"
            >
          </div>
  
          <button type="submit" class="submit-btn">
            登录
          </button>
        </form>
  
        <div class="register-link">
          <span>没有账号？</span>
          <router-link to="/register">立即注册</router-link>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { reactive } from 'vue'
  import { useRouter } from 'vue-router'
  import axios from 'axios'
  
  const router = useRouter()
  const form = reactive({
    username: '',
    password: ''
  })
  
  const handleLogin = async () => {
    try {
      const response = await axios.post('/admin/login', form)
      
      if (response.data.code === 200) {
        localStorage.setItem('isLoggedIn', 'true')//设置登录状态标记
        localStorage.setItem('userInfo', JSON.stringify({
          data: response.data.data//序列化后存入本地存储
      }))
        // 登录成功跳转到地址填写
        router.push('/myaddress')
      } else {
        alert(`登录失败：${response.data.message}`)
      }
    } catch (error) {
      const errorMsg = error.response?.data?.message || '请求异常，请检查网络'
      alert(`登录失败：${errorMsg}`)
    }
  }
  </script>
  
  <style scoped>
  .auth-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 500px;
    max-width: 500px;
    margin: 0 auto;
    background-size: cover;
    background-position: center; 

  }
  
  .form-wrapper {
    background: rgba(255, 255, 255, 0.8);
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 400px;
  }
  
  h2 {
    text-align: center;
    color: #1a1a1a;
    margin-bottom: 1.5rem;
    font-size: 1.5rem;
  }
  
  .form-group {
    margin-bottom: 1.2rem;
  }
  
  label {
    display: block;
    margin-bottom: 0.5rem;
    color: #606266;
    font-size: 0.9rem;


  }
  
  input {
    width: 90%;
    padding: 0.8rem;
    border: 1px solid #dcdfe6;
    border-radius: 4px;
    font-size: 1rem;
    transition: border-color 0.3s;
  }
  
  input:focus {
    outline: none;
    border-color: #ff6640;
    box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.1);
  }
  
  .submit-btn {
    width: 100%;
    padding: 0.8rem;
    background-color: #ac8314;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    margin-top: 1.5rem;
    transition: background-color 0.3s;
  }
  
  .submit-btn:hover {
    background-color: #ee852f;
  }
  
  .register-link {
    margin-top: 1.5rem;
    text-align: center;
    font-size: 0.9rem;
    color: #606266;
  }
  
  .register-link a {
    color: #91570c;
    text-decoration: none;
    margin-left: 0.5rem;
  }
  
  .register-link a:hover {
    text-decoration: underline;
  }
  </style>