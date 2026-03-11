<template>
    <div class="address-form">
      <h2>你为谁而来？</h2>
      <form @submit.prevent="saveAddress">
        <div class="form-group">
          <label for="receiverName">使用者姓名：</label>
          <input 
            type="text" 
            id="receiverName" 
            v-model="addressInfo.receiverName" 
            required
          >
        </div>
        
        <div class="form-group">
          <label for="receiverPhone">ta的电话：</label>
          <input 
            type="tel" 
            id="receiverPhone" 
            v-model="addressInfo.receiverPhone" 
            required
          >
        </div>
        
        <div class="form-group">
          <label for="address">ta在哪？</label>
          <textarea 
            id="address" 
            v-model="addressInfo.address" 
            required
          ></textarea>
        </div>
        
        <button type="submit">确定对ta使用</button>
      </form>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        addressInfo: {
          receiverName: '',
          receiverPhone: '',
          address: ''
        }
      }
    },
    methods: {
      saveAddress() {
        localStorage.setItem('shippingAddress', JSON.stringify(this.addressInfo));
        alert('欢迎进入命运商店！');
        this.$router.push('/products');
      }
    },
    mounted() {
      const savedAddress = localStorage.getItem('shippingAddress');
      if (savedAddress) {
        this.addressInfo = JSON.parse(savedAddress);
      }
    }
  }
  </script>
  
  <style scoped>
  .address-form {
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 400px;
    background: rgba(255, 255, 255, 0.8);
    
    margin: 0 auto;
    
  }
  .form-group {
    margin-bottom: 15px;
  }
  label {
    display: block;
    margin-bottom: 0.5rem;
    color: #606266;
    font-size: 0.9rem;
  }
  input, textarea {
    width: 90%;
    padding: 0.8rem;
    border: 1px solid #dcdfe6;
    border-radius: 4px;
    font-size: 1rem;
    transition: border-color 0.3s;
  }
  button {
    background-color: #42b983;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  input {
    width: 90%;
    padding: 0.8rem;
    border: 1px solid #dcdfe6;
    border-radius: 4px;
    font-size: 1rem;
    transition: border-color 0.3s;
  }
  
  input:focus {
    outline: none;
    border-color: #ff6640;
    box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.1);
  }
  </style>