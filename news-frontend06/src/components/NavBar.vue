<template>
  <nav class="navbar">
    <div class="container">
      <router-link to="/products" class="logo">◆命运商店</router-link>
      <div class="nav-content">
        <!-- 添加用户欢迎语 -->
        <span v-if="username" class="welcome-text">你好，{{ username }}</span>
        <div class="nav-links">
          <router-link to="/products">商品列表</router-link>
          <router-link to="/orders">我的订单</router-link>
          <router-link to="/cart">我的购物车</router-link>
          <router-link to="/favorites">我的收藏</router-link>
          <router-link to="/myprofile">个人资料</router-link>
          
          <button 
            v-if="isLoggedIn"
            @click="handleLogout" 
            class="logout-btn"
          >
            退出登录
          </button>
        </div>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const username = ref('')
const isLoggedIn = ref(false)

// 从localStorage获取用户信息
const loadUserInfo = () => {
  const userInfoString = localStorage.getItem('userInfo')
  if (userInfoString) {
    const userInfo = JSON.parse(userInfoString)
    username.value = userInfo.data.username || '用户'
    isLoggedIn.value = true
  }
}




// 退出登录
const handleLogout = () => {
  localStorage.removeItem('isLoggedIn')
  localStorage.removeItem('userInfo')
  router.push('/login')
}

// 组件挂载时加载用户信息
onMounted(() => {
  loadUserInfo()
})
</script>

<style scoped>
.navbar {
  background-color: #D8CDB7;

  padding: 1rem 0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  position: fixed;
  width: 100%;
  top: 0;
  z-index: 1000;
  
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 2rem;
  
}

.nav-content {
  display: flex;
  align-items: center;
  gap: 2rem;
}

.welcome-text {
  font-weight: 500;
  color: rgba(255, 255, 255, 0.9);
}

.logo {
  font-size: 1.5rem;
  font-weight: bold;
  color: rgb(33, 36, 22);
  text-decoration: none;
  font-family: 'Georgia', serif;
}

.nav-links {
  display: flex;
  gap: 1.5rem;
  align-items: center;
}

.nav-links a {
  color: white;
  text-decoration: none;
  font-weight: 500;
  transition: opacity 0.3s;
}

.nav-links a:hover {
  opacity: 0.8;
  color: rgb(148, 35, 35);
}

.nav-links a.router-link-active {
  text-decoration: underline;
  color: rgb(148, 35, 35);
}

.logout-btn {
  background: none;
  border: 1px solid white;
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.logout-btn:hover {
  background-color: rgba(255, 255, 255, 0.1);
}
</style>