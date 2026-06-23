import { createStore } from 'vuex';
import axios from 'axios';

export default createStore({
  state: {
    // 存储商品库存，key 是商品ID，value 是库存数量
    productStocks: {},
    // 购物车数据，key 是商品ID，value 是用户选择的商品数量
    cartItems: {},
    // 用户信息
    userInfo: null,
    // 登录状态
    isLoggedIn: false,
    // 商品列表
    products: [],
    // 收藏商品
    favorites: [],
    // 订单列表
    orders: [],
    // 收货地址
    shippingAddress: null,
    // 全局加载状态
    loading: false,
    // 加载计数器
    loadingCount: 0
  },
  mutations: {
    // 更新商品库存
    UPDATE_PRODUCT_STOCK(state, { productId, stock }) {
      state.productStocks[productId] = stock;
    },
    // 更新购物车商品数量
    UPDATE_CART_ITEM(state, { productId, quantity }) {
      state.cartItems[productId] = quantity;
    },
    // 移除购物车商品
    REMOVE_CART_ITEM(state, productId) {
      delete state.cartItems[productId];
    },
    // 设置用户信息
    SET_USER_INFO(state, userInfo) {
      state.userInfo = userInfo;
    },
    // 设置登录状态
    SET_LOGIN_STATUS(state, status) {
      state.isLoggedIn = status;
    },
    // 设置商品列表
    SET_PRODUCTS(state, products) {
      state.products = products;
    },
    // 设置收藏商品
    SET_FAVORITES(state, favorites) {
      state.favorites = favorites;
    },
    // 设置订单列表
    SET_ORDERS(state, orders) {
      state.orders = orders;
    },
    // 设置收货地址
    SET_SHIPPING_ADDRESS(state, address) {
      state.shippingAddress = address;
    },
    // 开始加载
    START_LOADING(state) {
      state.loadingCount++;
      state.loading = true;
    },
    // 结束加载
    FINISH_LOADING(state) {
      state.loadingCount = Math.max(0, state.loadingCount - 1);
      state.loading = state.loadingCount > 0;
    }
  },
  actions: {
    // 异步获取商品库存
    async fetchProductStock({ commit }, productId) {
      const response = await axios.get(`/products/${productId}/stock`);
      commit('UPDATE_PRODUCT_STOCK', { productId, stock: response.data.stock });
    },
    // 登录
    async login({ commit }, credentials) {
      try {
        const response = await axios.post('/admin/login', credentials);
        if (response.data.code === 200) {
          commit('SET_USER_INFO', response.data.data);
          commit('SET_LOGIN_STATUS', true);
          return { success: true };
        }
        return { success: false, message: response.data.message };
      } catch (error) {
        return { success: false, message: error.response?.data?.message || '请求异常' };
      }
    },
    // 登出
    logout({ commit }) {
      commit('SET_USER_INFO', null);
      commit('SET_LOGIN_STATUS', false);
    },
    // 获取商品列表 - 添加缓存
    async fetchProducts({ commit, state }) {
      try {
        // 如果已有数据且未过期，直接使用缓存
        const cacheTime = localStorage.getItem('productsCache_time');
        const now = Date.now();
        
        // 缓存有效期为5分钟
        if (state.products.length > 0 && cacheTime && (now - parseInt(cacheTime)) < 300000) {
          return { success: true };
        }
        
        const response = await axios.get("/products/search");
        if (response.data.code === 200) {
          const products = response.data.data.map(product => {
            commit('UPDATE_PRODUCT_STOCK', {
              productId: product.id,
              stock: product.stock
            });
            return { ...product, price: Number(product.price) || 0 };
          });
          commit('SET_PRODUCTS', products);
          
          // 更新缓存时间
          localStorage.setItem('productsCache_time', now.toString());
          return { success: true };
        }
        return { success: false, message: response.data.message };
      } catch (error) {
        return { success: false, message: '获取商品列表失败' };
      }
    },
    // 获取购物车数据
    async fetchCartItems({ commit }, userId) {
      try {
        const response = await axios.get(`cart/details?userId=${userId}`);
        if (response.data.code === 200) {
          // 更新购物车数据
          response.data.data.forEach(item => {
            commit('UPDATE_CART_ITEM', { 
              productId: item.productId, 
              quantity: item.quantity 
            });
          });
          return { success: true, data: response.data.data };
        }
        return { success: false, message: response.data.message };
      } catch (error) {
        return { success: false, message: '获取购物车失败' };
      }
    },
    // 通用加载方法
    async fetchWithLoading({ commit }, { apiCall, successCallback, errorCallback }) {
      commit('START_LOADING');
      try {
        const response = await apiCall();
        if (successCallback) successCallback(response);
        return response;
      } catch (error) {
        if (errorCallback) errorCallback(error);
        return { success: false, error };
      } finally {
        commit('FINISH_LOADING');
      }
    }
  },
  getters: {
    // 获取商品库存
    getProductStock: (state) => (productId) => {
      return state.productStocks[productId] || 0;
    },
    // 获取购物车商品数量
    getCartItemQuantity: (state) => (productId) => {
      return state.cartItems[productId] || 0;
    },
    // 获取用户信息
    getUserInfo: (state) => {
      return state.userInfo;
    },
    // 获取登录状态
    isLoggedIn: (state) => {
      return state.isLoggedIn;
    },
    // 获取商品列表
    getProducts: (state) => {
      return state.products;
    },
    // 获取收货地址
    getShippingAddress: (state) => {
      return state.shippingAddress;
    },
    // 获取全局加载状态
    isLoading: (state) => {
      return state.loading;
    }
  }
});
