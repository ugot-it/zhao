<template>
    <div class="company-profile">
      <!-- 顶部大图展示 -->
      <div class="hero-banner">
        <img 
          src="../../image/catt.png" 
          alt="大背景"
          class="banner-image"
        >
        <div class="banner-overlay">
          <h1>双头猫工作室</h1>
          <p>让您重获新生</p>
        </div>
      </div>
  

  
      <!-- 公司文化 -->
      <div class="culture-section">
        <div class="container">
          <h2 class="section-title">企业文化</h2>
          <div class="culture-grid">
            <div class="culture-card">
              <div class="culture-icon">❤️</div>
              <h3>仅向特定顾客开放</h3>
              <p>我们提供非标准化解决方案，商品目录任君选择，确保每一笔交易都如愿</p>
            </div>
            <div class="culture-card">
              <div class="culture-icon">🎉</div>
              <h3>我们拥有特殊的支付渠道</h3>
              <p>与全球200w+合作伙伴建立长期战略合作关系。</p>
            </div>
            <div class="culture-card">
              <div class="culture-icon">🎂</div>
              <h3>绝不后悔</h3>
              <p>我们从不主动推销，也不接受任何售后投诉</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: 'CompanyProfile'
  }
  </script>
  
  <style scoped>
  /* 基础样式 */
  .company-profile {
    font-family: 'Helvetica Neue', Arial, sans-serif;
    color: #333;
    line-height: 1.6;
    width: 80%;
    margin: 0 auto;
  }
  
  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }
  
  .section-title {
    text-align: center;
    font-size: 2.5rem;
    margin-bottom: 3rem;
    color: #2c3e50;
    position: relative;
  }
  
  .section-title::after {
    content: '';
    display: block;
    width: 80px;
    height: 4px;
    background: #c0a786;
    margin: 15px auto;
  }
  
  /* 顶部大图样式 */
  .hero-banner {
    position: relative;
    height: 70vh;
    overflow: hidden;
  }
  
  .banner-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    filter: brightness(0.8);
  }
  
  .banner-overlay {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    color: white;
    width: 100%;
  }
  
  .banner-overlay h1 {
    font-size: 4rem;
    margin-bottom: 1rem;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
  }
  
  .banner-overlay p {
    font-size: 1.5rem;
    letter-spacing: 3px;
  }
  
  
  /* 企业文化样式 */
  .culture-section {
    padding: 80px 0;
    background: rgba(255, 255, 255, 0.8);
  }
  
  .culture-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
    margin-top: 40px;
  }
  
  .culture-card {
    text-align: center;
    padding: 40px 20px;
    border-radius: 8px;
    transition: transform 0.3s ease;
    background: rgba(235, 180, 135, 0.5);
  }
  
  .culture-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 15px 30px rgba(0,0,0,0.1);
  }
  
  .culture-icon {
    font-size: 3rem;
    margin-bottom: 20px;
  }
  
  .culture-card h3 {
    color: #2c3e50;
    margin-bottom: 15px;
  }
  
  /* 响应式调整 */
  @media (max-width: 768px) {
    .hero-banner {
      height: 50vh;
    }
    
    .banner-overlay h1 {
      font-size: 2.5rem;
    }
    
    .timeline::before {
      left: 31px;
    }
    
    .timeline-item {
      width: 100%;
      padding-left: 70px;
      padding-right: 25px;
    }
    
    .timeline-item:nth-child(even) {
      left: 0;
    }
  }
  </style>