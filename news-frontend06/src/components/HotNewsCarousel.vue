<template>
  <div>
    <div v-if="loading" class="loading">加载中...</div>
    <div v-else-if="error" class="error">{{ error }}</div>
    <div v-else class="news-carousel">
      <div class="carousel-track">
        <div
          v-for="(item, idx) in items"
          :key="item.id"
          class="carousel-item"
          :class="{
            active: idx === current,
            prev: idx === prevIndex,
            next: idx === nextIndex
          }"
          @click="handleItemClick(idx, item.link)"
        >
        <img
          v-if="item.imageUrl"
          :src="getImageUrl(item.imageUrl)"
          class="carousel-image"
          alt="资讯图片"
          @error="handleImageError"
          />
          <div v-else class="image-placeholder">暂无图片</div>
          <div class="carousel-title">{{ item.title }}</div>
        </div>
      </div>
      <div class="carousel-dots">
        <span
          v-for="(item, idx) in items"
          :key="item.id"
          class="dot"
          :class="{ active: idx === current }"
          @click="show(idx)"
        ></span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import axios from 'axios'

const items = ref([])
const loading = ref(true)
const error = ref(null)
// 配置后端图片基础URL
const BASE_IMAGE_URL = import.meta.env.VITE_IMAGE_BASE_URL || 'http://localhost:8080/api/image/'

const getImageUrl = (relativePath) => {
  if (!relativePath) return ''
  // 只取文件名，拼接到后端图片接口
  const filename = relativePath.split('/').pop()
  return `${BASE_IMAGE_URL}${filename}`
}
//获取消息
const fetchHotNews = async () => {
  loading.value = true
  error.value = null
  try {
    const response = await axios.get('http://localhost:8080/api/news/hot')
    if (response.data.code === 200) {
      items.value = response.data.data
    } else {
      error.value = '获取数据失败'
    }
  } catch (err) {
    error.value = '加载热点资讯失败'
    console.error(err)
  } finally {
    loading.value = false
  }
}
const current = ref(0)
const total = computed(() => items.value.length)
const prevIndex = computed(() => (current.value - 1 + total.value) % total.value)
const nextIndex = computed(() => (current.value + 1) % total.value)

let timer = null
const startAuto = () => {
  timer = setInterval(() => {
    show((current.value + 1) % total.value)
  }, 3000)
}
const stopAuto = () => clearInterval(timer)

function show(idx) {
  if (idx < 0 || idx >= total.value) return
  current.value = idx
  stopAuto()
  startAuto()
}

function handleItemClick(idx, link) {
  if (idx === current.value) {
    window.open(link, '_blank')
  } else {
    show(idx)
  }
}

function handleImageError(event) {
  event.target.style.display = 'none'
  const placeholder = document.createElement('div')
  placeholder.className = 'image-placeholder'
  placeholder.textContent = '图片加载失败'
  event.target.parentNode.appendChild(placeholder)
}

onMounted(async () => {
  await fetchHotNews()
  if (total.value > 0) {
    startAuto()
  }
})

onUnmounted(() => {
  stopAuto()
})
</script>

<style scoped>
/*整个组件 */
.news-carousel {
  width: 700px; /* 容器宽度稍微宽一些，适应更大图片 */
  margin: 0 auto;
  position: relative;
}
/*图片的轮播轨道 */
.carousel-track {
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
  height: 300px; 
}
/*单张轮播图片及其标题卡片 */
.carousel-item {
  position: absolute;
  left: 50%;
  top: 0;
  width: 500px; 
  height: 300px; 
  opacity: 0;
  transform: translateX(-50%) scale(0.75); /* 初始缩放比例稍大，图片更明显 */
  transition: all 0.6s cubic-bezier(0.4,0,0.2,1);
  z-index: 1;
  cursor: pointer;
  box-shadow: 0 4px 24px rgba(55, 97, 79, 0.715);
  border-radius: 12px;
  background: #fff;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  overflow: hidden;
  background-color: transparent;
}
/**/
.carousel-item img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.carousel-item .carousel-title {
  background-color: transparent;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.8), transparent);
  color: #ffffff;
  padding: 10px;
  font-size: 1.2rem; /* 字号稍微调大，适应更大图片 */
  text-align: left;
  font-family: 'Georgia', serif;
  text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff; /* 三层发光效果 */
  
}
/*展示图片*/
.carousel-item.active {
  opacity: 1;/*透明度*/
  transform: translateX(-50%) scale(1);/*居中显示，大小不变*/
  z-index: 3;/*在所有图片上*/
}
/*即将要展示的图片*/
.carousel-item.prev {
  opacity: 0.6; 
  transform: translateX(-110%) scale(0.85); /* 缩放比例更大，位置更靠近中心，间隙更紧凑 */
  z-index: 2;
}
/*展示过的图片（右边*/
.carousel-item.next {
  opacity: 0.6;
  transform: translateX(10%) scale(0.85);
  z-index: 2;
}


/*小圆点的容器*/
.carousel-dots {
  text-align: center;
  margin-top: 20px;
}

.dot {
  display: inline-block;
  width: 12px; /* 小圆点改大点，更好点击 */
  height: 12px;
  background: #b5b5b5;
  border-radius: 50%;
  margin: 0 6px;
  cursor: pointer;
  transition: background 0.3s;
}

.dot.active {
  background: #c29d2b;
}


</style>
