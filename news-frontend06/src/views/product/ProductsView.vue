<template>
  <PromoSlider :items="combos" />

  <navbar />
  <div class="products-container">
    <!-- 顶部搜索栏 -->
    <div class="search-bar">
      <input
        v-model="searchKeyword"
        type="text"
        placeholder="搜索商品..."
        @keyup.enter="searchProducts"
      />
      <button @click="searchProducts">搜索</button>
    </div>

    <!-- 热点资讯 -->
    <HotNewsCarousel :items="hotNews" />

    <!-- 热销商品 -->
    <HotProductSlider :items="hotProducts" />

    <!-- 商品分类栏 -->
    <div class="category-bar">
      <div
        v-for="category in categories"
        :key="category.id"
        :class="['category-item', { active: activeCategory === category.id }]"
        @click="filterByCategory(category.id)"
      >
        {{ category.name }}
      </div>
    </div>

    <!-- 商品列表 -->
    <div v-if="loading" class="loading">加载中...</div>
    <div v-else>
      <div v-if="products.length === 0" class="no-data">暂无商品数据</div>
      <div v-else class="products-list">
        <div v-for="product in products" :key="product.id" class="product-card">
          <img
            v-if="product.imageUrl"
            :src="getProductImageUrl(product.imageUrl)"
            class="product-image"
            alt="商品图片"
            @error="handleImageError"
          />
          <div v-else class="image-placeholder">暂无图片</div>
          <div class="product-info">
            <h3 class="product-name">{{ product.name }}</h3>
            <p class="product-desc">{{ product.description }}</p>
            <div class="product-meta">
              <span class="product-price">¥{{ product.price.toFixed(2) }}</span>
              <span class="product-stock">库存: {{ product.stock }}</span>
            </div>
            <button class="detail-btn" @click="viewProductDetail(product.id)">
              查看详情
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script setup>
import { ref, computed, onMounted, onUnmounted } from "vue";
import { useStore } from "vuex"; //vuex存储商品库存
import { useRouter } from "vue-router";
import axios from "axios";
import navbar from "../../components/NavBar.vue";
import HotNewsCarousel from "../../components/HotNewsCarousel.vue";
import HotProductSlider from "../../components/HotProductSlider.vue";

const store = useStore();
// 静态数据 - 热销商品
const hotProducts = ref([
  {
    id: 1,
    name: "《帝国勇士排行榜》新书发售——作家亲签",
    price: 299,
    image: "src/image/1.1.png",
  },
  {
    id: 2,
    name: "Monarchs限定套装",
    price: 599,
    image: "src/image/2.1.png",
  },
  {
    id: 3,
    name: "Mysteries解谜礼盒",
    price: 399,
    image: "src/image/4.1.png",
  },
  {
    id: 4,
    name: "限量版收藏卡",
    price: 899,
    image: "src/image/3.1.png",
  },
]);

const router = useRouter();
const products = ref([]); // 商品列表数据
const loading = ref(true); // 加载状态
const searchKeyword = ref(""); // 搜索关键词
const categories = ref([
  { id: 0, name: "全部" },
  { id: 1, name: "金品质" },
  { id: 2, name: "银品质" },
  { id: 3, name: "铜品质" },
  { id: 4, name: "石品质" },
]);
const activeCategory = ref(0); // 当前选中的分类
const featuredSlider = ref([]); // 滑块DOM引用

// 配置后端图片基础URL（建议放在环境变量中）
const BASE_IMAGE_URL =
  import.meta.env.VITE_IMAGE_BASE_URL || "http://localhost:8080/api/image/";

// 获取完整图片URL
const getProductImageUrl = (relativePath) => {
  if (!relativePath) return "";

  // 处理可能存在的路径问题，提取文件名
  const filename = relativePath.split("/").pop();
  return `${BASE_IMAGE_URL}${filename}`;
};

// 图片加载失败处理
const handleImageError = (event) => {
  event.target.style.display = "none";
  const placeholder = document.createElement("div");
  placeholder.className = "image-placeholder";
  placeholder.textContent = "图片加载失败";
  event.target.parentNode.insertBefore(placeholder, event.target.nextSibling);
};

// 获取商品列表
// 获取商品列表数据
const fetchProducts = async () => {
  try {
    loading.value = true;
    // 调用后端API获取商品列表
    const response = await axios.get("/products/search");

    if (response.data.code === 200) {
      // products.value = response.data.data.map((product) => ({
      //   ...product,
      //    确保price是数字类型
      //   price: Number(product.price) || 0,
      // }));

      products.value = response.data.data.map((product) => {
        // 将商品库存存入 Vuex
        store.commit("UPDATE_PRODUCT_STOCK", {
          productId: product.id,
          stock: product.stock,
        });
        return { ...product, price: Number(product.price) || 0 };
      });
    } else {
      console.error("获取商品失败:", response.data.message);
    }
  } catch (error) {
    console.error("请求失败:", error);
    alert("获取商品列表失败，请稍后重试");
  } finally {
    loading.value = false;
  }
};

// 搜索商品
// 按分类筛选商品
// 参数categoryId: 用户点击的分类ID
const filterByCategory = async (categoryId) => {
  // 设置当前选中的分类ID
  activeCategory.value = categoryId;

  try {
    loading.value = true;
    const response = await axios.get("/products/search", {
      params: {
        keyword: searchKeyword.value,
        categoryId: categoryId === 0 ? null : categoryId,
      },
    });

    if (response.data.code === 200) {
      products.value = response.data.data.map((product) => ({
        ...product,
        price: Number(product.price) || 0,
      }));
    }
  } catch (error) {
    console.error("分类筛选失败:", error);
  } finally {
    loading.value = false;
  }
};

const searchProducts = async () => {
  try {
    loading.value = true;
    const response = await axios.get("/products/search", {
      params: {
        keyword: searchKeyword.value,
        categoryId: activeCategory.value === 1 ? null : activeCategory.value,
      },
    });

    if (response.data.code === 200) {
      products.value = response.data.data.map((product) => ({
        ...product,
        price: Number(product.price) || 0,
      }));
    }
  } catch (error) {
    console.error("搜索失败:", error);
  } finally {
    loading.value = false;
  }
};

// 滑块滚动控制
const scrollSlider = (direction) => {
  if (featuredSlider.value) {
    const scrollAmount = featuredSlider.value.clientWidth * 0.8 * direction;
    featuredSlider.value.scrollBy({
      left: scrollAmount,
      behavior: "smooth",
    });
  }
};

// 查看商品详情
const viewProductDetail = (productId) => {
  router.push(`/products/${productId}`);
};

// 修改onMounted加载数据
onMounted(async () => {
  fetchProducts();
});
</script>

<style scoped>
.products-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.category-bar {
  display: flex;
  gap: 15px;
  margin: 20px 0;
  padding: 10px 0;
  overflow-x: auto;
  scrollbar-width: none;
}

.category-bar::-webkit-scrollbar {
  display: none;
  width: 200px;
}

.category-item {
  padding: 16px 32px;
  border-radius: 20px;
  background: #f5f5f5;
  cursor: pointer;
  white-space: nowrap;
  transition: all 0.3s;
  margin: 2rem auto 2rem;
}

.category-item:hover {
  background: #e0e0e0;
}

.category-item.active {
  color: white;
  margin: 2rem auto 2rem;
  padding: 16px 32px;
  background: linear-gradient(145deg, #1f1f1f, #292929); /* 金属质感暗色渐变 */
  border: 2px solid #fff371; /* 商品的边框 */
}

.search-bar {
  display: flex;
  margin-bottom: 2rem;
  gap: 1rem;
}

.search-bar input {
  flex: 1;
  padding: 0.8rem;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  font-size: 1rem;
}

.search-bar button {
  padding: 0 2rem;
  background-color: #35393d;
  color: #b8b276;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  border: 2px solid #b8b276;
  font-family: "Georgia", serif;
}

.loading,
.no-data {
  text-align: center;
  padding: 2rem;
  color: #666;
}

.products-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(560px, 1fr));
  gap: 2rem;
}

.product-card {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s;
  display: flex;
}

.product-card:hover {
  transform: translateY(-5px);
}

.product-image {
  width: 240px;
  height: 240px;
  object-fit: cover;
}
.product-image-container {
  height: 140px;
  background: #fafafa;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 4px;
  margin-bottom: 12px;
  overflow: hidden;
}

.image-placeholder {
  width: 240px;
  height: 240px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f5f5f5;
  color: #999;
}

.product-info {
  padding: 1.5rem;
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.product-name {
  margin: 0 0 0.5rem;
  color: #303133;
  font-size: 1.2rem;
}

.product-desc {
  color: #606266;
  font-size: 0.9rem;
  margin-bottom: 1rem;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.product-meta {
  display: flex;
  justify-content: space-between;
  margin-bottom: 1rem;
}

.product-price {
  color: #f56c6c;
  font-weight: bold;
  font-size: 1.2rem;
}

.product-stock {
  color: #909399;
}

.detail-btn {
  width: 100%;
  padding: 0.8rem;
  background: linear-gradient(145deg, #1f1f1f, #292929);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.detail-btn:hover {
  background: linear-gradient(145deg, #1f1f1f, #292929);
}
</style>