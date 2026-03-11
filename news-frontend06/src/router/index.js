import { createRouter,createWebHistory } from "vue-router";

const routes = [
    {path: '/', redirect: '/login'},
    {path: '/login',component: () => import('../views/auth/LoginView.vue')},
    {path: '/register',component: () => import('../views/auth/RegisterView.vue')},
   
  // 新增商品相关路由
  { path: '/products', component: () => import('../views/product/ProductsView.vue') },
  { path: '/products/:id', component: () => import('../views/product/ProductDetail.vue')},
  //订单路由

  { path: '/orders', component: () => import('../views/order/OrdersView.vue') },
  { path: '/orders/:orderId', component: () => import('../views/order/OrderDetailView.vue') },
  { path: '/navbar', component: () => import('../components/NavBar.vue') },
  //个人主页
  { path: '/profile', component: () => import('../views/profile/ProfileView.vue') },
  { path: '/myprofile', component: () => import('../views/profile/MyProfileView.vue') },
  //收藏页面
  { path: '/favorites', component: () => import('../views/favo/FavoritesView.vue') },
  //购物车页面
  { path: '/cart', component: () => import('../views/cart/CartView.vue') },
  //地址
  { path: '/myaddress', component: () => import('../views/profile/AddressView.vue') },
  //生产商简介
  { path: '/adone', component: () => import('../views/ad/AdOneView.vue') },
  { path: '/adtwo', component: () => import('../views/ad/AdTwoView.vue') },
  { path: '/adthr', component: () => import('../views/ad/AdThrView.vue') },

   
      
    
  
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router
