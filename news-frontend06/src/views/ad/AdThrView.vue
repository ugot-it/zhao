<template>
  <div class="company-profile">
    <!-- 顶部大图展示 -->
    <div class="hero-banner">
      <img src="../../image/yuanzuo.png" alt="大背景" class="banner-image" />
      <div class="banner-overlay">
        <h1>苏丹的游戏</h1>
        <p>灵感来源</p>
      </div>
    </div>

    <div class="company-description">
      <div class="company-section">
        
        <h2 >游戏简介</h2>
        <p>
          苏丹被神秘女术士蛊惑，命令你和他玩一个残酷的游戏。
          每周你必须从四种特殊的卡片中抽一张：纵欲卡需要你寻找床笫之欢，
          奢靡卡需要你挥金如土，征服卡将逼迫你深入险境，
          而杀戮卡则需要你献祭一条人命……是和这个游戏一同陷入疯狂，
          还是寻找那缥缈的希望？
        </p>
        <h2 >公司</h2>
        <p>
            XX公司成立于2005年，是一家专注于科技创新领域的企业。
          经过十余年的发展，我们已成长为行业领先的解决方案提供商。
          公司始终秉持"诚信、创新、共赢"的核心价值观，
          为全球客户提供优质产品与服务。
        </p>
        <p>
            XX公司成立于2005年，是一家专注于科技创新领域的企业。
          经过十余年的发展，我们已成长为行业领先的解决方案提供商。
          公司始终秉持"诚信、创新、共赢"的核心价值观，
          为全球客户提供优质产品与服务。
        </p>
        <h2> ❤️</h2>
      </div>
    </div>
  </div>
</template>
  
  <script>
export default {
  name: "CompanyIntro",
};
</script>
  
  <style scoped>
/* 基础样式 */
.company-profile {
  font-family: "Helvetica Neue", Arial, sans-serif;
  color: #333;
  line-height: 1.6;
  width: 80%;
  margin: 0 auto;
}
.company-section {
  padding: 80px 0;
  margin: 0 auto;
  padding: 0 20px;
  width: 80%;
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
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

.banner-overlay p {
  font-size: 1.5rem;
  letter-spacing: 3px;
}

.company-description {
      background: rgba(255, 255, 255, 0.8);
  text-align: center;
  margin: 0 auto;

}

.company-description h2 {

  font-weight: 600;
  letter-spacing: 1px;
  display: inline-block;
  text-align: center;
    font-size: 2.5rem;
    margin-bottom: 3rem;
    color: #2c3e50;
    position: relative;
}

.company-description h2:after {
    content: '';
    display: block;
    width: 80px;
    height: 4px;
    background: #c0a786;
    margin: 15px auto;
}

.company-description p {
    font-size: 1.1rem;
  line-height: 1.8;
  text-align: left;
  margin-bottom: 1.8rem;
  color: #444;
}

@media (max-width: 768px) {
  .company-description {
    padding: 0 20px;
  }
  
  .company-description h2 {
    font-size: 1.8rem;
  }

  .company-description p {
    font-size: 1rem;
  }
}
</style>