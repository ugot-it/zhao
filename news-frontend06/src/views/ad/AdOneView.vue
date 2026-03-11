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
          <p>为您排忧解难</p>
        </div>
      </div>
  
      <!-- 公司历史介绍 -->
      <div class="history-section">
        <div class="container">
          <h2 class="section-title">公司历史</h2>
          <div class="timeline">
            <div class="timeline-item">
              <div class="timeline-year">6ㄣƐϛƖ</div>
              <div class="timeline-content">
                <h3>公司成立</h3>
                <p>若看到这段文字，说明你已进入客户名单。我们很快见面。</p>
              </div>
            </div>
            <div class="timeline-item">
              <div class="timeline-year">ㄣƐᄅㄥㄣ</div>
              <div class="timeline-content">
                <h3>业务扩展</h3>
                <p>成功拓展支付市场————灵魂分期付款和记忆典当</p>
              </div>
            </div>
            <div class="timeline-item">
              <div class="timeline-year">2025</div>
              <div class="timeline-content">
                <h3>数字化转型</h3>
                <p>本商店无固定地址，无工商注册，且拒绝承认与任何现实或超自然实体有关联。推门而入即视为同意。</p>
              </div>
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
  
  /* 历史时间线样式 */
  .history-section {
    padding: 80px 0;
    background: rgba(255, 255, 255, 0.8);
  }
  
  .timeline {
    position: relative;
    max-width: 800px;
    margin: 0 auto;
  }
  
  .timeline::before {
    content: '';
    position: absolute;
    width: 2px;
    background-color: #c0a786;
    top: 0;
    bottom: 0;
    left: 50%;
    margin-left: -1px;
  }
  
  .timeline-item {
    padding: 20px 40px;
    position: relative;
    width: 50%;
    box-sizing: border-box;
  }
  
  .timeline-item:nth-child(odd) {
    left: 0;
  }
  
  .timeline-item:nth-child(even) {
    left: 50%;
  }
  
  .timeline-year {
    background-color: #c0a786;
    color: white;
    padding: 10px 20px;
    border-radius: 20px;
    font-weight: bold;
    display: inline-block;
    margin-bottom: 15px;
  }
  
  .timeline-content {
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
  }
  
  .timeline-content h3 {
    margin-top: 0;
    color: #c0a786;
  }
  
  
  </style>