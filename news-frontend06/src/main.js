import { createApp } from 'vue'

import App from './App.vue'
import store from './store';
import router from './router'



const app = createApp(App)

//设置反向代理，前端请求默认发送到 http://localhost:8080
//导入模块
import axios from 'axios'
//全局注册，之后可在其他组件中通过 this.$axios 发送数据
axios.defaults.baseURL = 'http://localhost:8080/api'
//axios挂载到vue实例
app.config.globalProperties.$axios = axios

app.use(router)
app.mount('#app')
app.use(store); // 注册 Vuex
