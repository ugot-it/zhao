<template>
    <div class="hot-slider">
      <h2 class="slider-title">🔥 热销商品</h2>
      <div class="slider-container">
        <button class="slider-arrow left" @click="scroll(-1)">‹</button>
        <div class="slider-list" ref="sliderRef">
          <div
            v-for="item in items"
            :key="item.id"
            class="slider-card"
            @click="goDetail(item.id)"
          >
            <div class="img-wrap">
              <img :src="item.image" :alt="item.name" />
              <span class="hot-tag">热销</span>
            </div>
            <div class="card-info">
              <h3 class="card-title">{{ item.name }}</h3>
              <p class="card-price">¥{{ item.price }}</p>
            </div>
          </div>
        </div>
        <button class="slider-arrow right" @click="scroll(1)">›</button>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'
  
  const props = defineProps({
    items: {
      type: Array,
      required: true
    }
  })
  
  const sliderRef = ref(null)
  const router = useRouter()
  
  // 滑动函数
  function scroll(dir) {
    if (sliderRef.value) {
      const cardWidth = sliderRef.value.querySelector('.slider-card')?.offsetWidth || 260
      sliderRef.value.scrollBy({
        left: dir * (cardWidth + 24), // 24是gap
        behavior: 'smooth'
      })
    }
  }
  
  // 跳转详情
  function goDetail(id) {
    router.push(`/products/${id}`)
  }
  </script>
  
  <style scoped>

  /* 整个大盒 */
  .hot-slider {
    
    margin: 2.5rem 0;
    opacity: 0.9; 
  background: #D8CDB7; /* 米色墙面做背景 */
  padding: 20px 0;
  border-radius: 12px;
  box-shadow: 0 0 30px #000000aa; /*深色的描边 */
  
}
  .slider-title {
    opacity: 1; 
    text-align: center;
    font-size: 1.5rem;
    margin-bottom: 1.2rem;
    color: #000000;
    font-family: 'Georgia', serif;
    letter-spacing: 1px;
  }
  .slider-container {
    position: relative;
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    align-items: center;
  }
  .slider-list {
    display: flex;
    gap: 24px;
    overflow-x: auto;
    scroll-snap-type: x mandatory;
    padding: 10px 0;
    scrollbar-width: none;
    flex: 1;
  }
  .slider-list::-webkit-scrollbar {
    display: none;
  }
  .slider-card {
    min-width: 260px;
  max-width: 260px;
  background: linear-gradient(145deg, #1f1f1f, #292929); /* 金属质感暗色渐变 */
  border: 2px solid #fff371; /* 商品的边框 */
  border-radius: 12px;
  box-shadow: 0 0 10px #F8DE97;
  cursor: pointer;
  transition: transform 0.3s, box-shadow 0.3s;
  scroll-snap-align: start;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  }
  .slider-card:hover {
    transform: translateY(-10px) scale(1.05);
  box-shadow: 0 0 20px #ffb800ee, 0 0 30px #ffb800cc;
  }
  .img-wrap {
    position: relative;
  width: 100%;
  aspect-ratio: 1/1;
  background: #363636; /* 深色背景 */
  overflow: hidden;
  border-bottom: 2px solid #F8DE97;
  }
  .img-wrap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }

  .card-info {
    padding: 14px 14px 10px 14px;
    text-align: left;
  }
  .card-title {
    color: #F8DE97;
  font-size: 1.1rem;
  font-family: 'Georgia', serif;
  margin-bottom: 4px;
  }
  .card-price {
    color: #F8DE97;
  font-size: 1.1rem;
  font-weight: bold;
  font-family: 'Georgia', serif;
  }
  .slider-arrow {
    background: #fff;
    border: none;
    border-radius: 50%;
    box-shadow: 0 2px 8px rgba(0,0,0,0.13);
    width: 38px;
    height: 38px;
    font-size: 1.4rem;
    color: #d39f0d;
    cursor: pointer;
    z-index: 2;
    transition: background 0.2s, color 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .slider-arrow:hover {
    background: #F8DE97;
    color: #fff;
  }
  .slider-arrow.left { margin-right: 10px; }
  .slider-arrow.right { margin-left: 10px; }



  .hot-tag {
    position: absolute;
  top: 10px;
  left: 10px;
  background: #F8DE97;
  color: #322f2f;
  font-size: 0.85rem;
  padding: 4px 12px;
  border-radius: 20px;
  font-weight: 900;
  letter-spacing: 1.5px;
  text-transform: uppercase;
  box-shadow: 0 0 8px #ffb800aa;

  }
  </style>
  