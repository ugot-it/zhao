<template>
    <div class="auth-container">
      <div class="form-wrapper">
        <h2>用户注册</h2>
        
        <form @submit.prevent="handleRegister">
          <div class="form-group">
            <label>用户名</label>
            <input 
              v-model="form.username" 
              type="text" 
              required
              placeholder="请输入您的名字"
            >
          </div>
          
          <div class="form-group">
            <label>密码</label>
            <input
              v-model="form.password"
              type="password"
              required
              placeholder="请输入密码（至少6位）"
              minlength="6"
            >
          </div>
  
          <div class="form-group">
            <label>确认密码</label>
            <input
              v-model="confirmPassword"
              type="password"
              required
              placeholder="请再次输入密码"
              :class="{ 'input-error': showPasswordError }"
            >
            <p v-if="showPasswordError" class="error-msg">两次输入的密码不一致</p>
          </div>
  
          <button 
            type="submit" 
            class="submit-btn"
            :disabled="isSubmitting"
          >
            {{ isSubmitting ? '注册中...' : '立即注册' }}
          </button>
        </form>
  
        <div class="login-link">
          <span>已有账号？</span>
          <router-link to="/login">立即登录</router-link>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { reactive, ref, computed } from 'vue'
  import { useRouter } from 'vue-router'
  import axios from 'axios'
  
  const router = useRouter()
  const isSubmitting = ref(false)
  
  // 表单数据
  const form = reactive({
    username: '',
    password: ''
  })
  
  // 确认密码
  const confirmPassword = ref('')
  
  // 密码校验
  const showPasswordError = computed(() => {
    return confirmPassword.value && form.password !== confirmPassword.value
  })
  
  // 处理注册请求
  const handleRegister = async () => {
    if (form.password !== confirmPassword.value) {
      alert('两次输入的密码不一致')
      return
    }
  
    try {
      isSubmitting.value = true
      const response = await axios.post('/admin/register', {
        username: form.username,
        password: form.password
      })
  
      if (response.data.code === 200) {
        alert('注册成功，请登录')
        router.push('/login')
      } else {
        alert(`注册失败：${response.data.message}`)
      }
    } catch (error) {
      const errorMsg = error.response?.data?.message || '注册请求异常'
      alert(`注册失败：${errorMsg}`)
    } finally {
      isSubmitting.value = false
      form.username = ''
      form.password = ''
      confirmPassword.value = ''
    }
  }
  </script>
  
  <style scoped>
  .auth-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;

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
  
  .input-error {
    border-color: #f56c6c;
  }
  
  .input-error:focus {
    box-shadow: 0 0 0 2px rgba(245, 108, 108, 0.1);
  }
  
  .error-msg {
    color: #f56c6c;
    font-size: 0.8rem;
    margin-top: 0.3rem;
  }
  
  .submit-btn {
    width: 100%;
    padding: 0.8rem;
    background-color: #67c23a;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1rem;
    margin-top: 1.5rem;
    transition: background-color 0.3s;
  }
  
  .submit-btn:disabled {
    background-color: #b3e19d;
    cursor: not-allowed;
  }
  
  .submit-btn:hover:not(:disabled) {
    background-color: #85ce61;
  }
  
  .login-link {
    margin-top: 1.5rem;
    text-align: center;
    font-size: 0.9rem;
    color: #606266;
  }
  
  .login-link a {
    color: #67c23a;
    text-decoration: none;
    margin-left: 0.5rem;
  }
  
  .login-link a:hover {
    text-decoration: underline;
  }
  </style>