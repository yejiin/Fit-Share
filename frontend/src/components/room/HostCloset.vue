<template>
  <!-- <div class="collapse" id="collapseExample">
    <div class="d-flex input-style">
      <div class="d-flex flex-column">
        <div>
          상품 주소
        </div>
        <input type="text" placeholder="사이트 Url 입력" class="site-url mt-1" v-model="SiteUrl">
        <div class="mt-1">
          이미지 주소
        </div>
        <input type="text" placeholder="이미지 Url 입력" class="img-url mt-1" v-model="ImgUrl">
      </div>
      <div class="d-flex justify-content-center align-items-center button-box">
        <button @click="AddUrl">
          +
        </button>
      </div>
    </div>
    
    <host-closet-item class="host-closet-item mt-5"></host-closet-item>
  </div> -->
  <div class="accordion" id="accordionExample">
      <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
        <div class="accordion-body">
          <div class="d-flex input-style">
            <div class="d-flex flex-column">
              <div class="head-style">
                상품 주소
              </div>
              <input type="text" placeholder="사이트 Url 입력" class="site-url mt-1" v-model="SiteUrl">
              <div class="mt-1 head-style">
                이미지 주소
              </div>
              <input type="text" placeholder="이미지 Url 입력" class="img-url mt-1" v-model="ImgUrl">
            </div>
            <div class="d-flex justify-content-center align-items-center button-box ms-2">
              <button @click="AddUrl">
                +
              </button>
            </div>
          </div>
        </div>
      </div>
      
      <img src="@/assets/shirt.jpg" alt="">
  </div>
</template>

<script>
import { ref } from 'vue'
// import HostClosetItem from './HostClosetItem.vue'

export default {
  name: 'HostCloset',
  components: {
    // HostClosetItem,
  },
  setup() {
  
    const SiteUrl = ref('')
    const ImgUrl = ref('')

    const Urls = ref('')

    const AddUrl = () => {
      if(SiteUrl.value.length < 1 && ImgUrl.value.length > 1) {
        alert('상품 주소를 입력하세요')
      } 
      else if(ImgUrl.value.length < 1 && SiteUrl.value.length > 1) {
        alert('이미지 주소를 입력하세요')
      } 
      else if(SiteUrl.value.length < 1 && ImgUrl.value.length < 1) {
        alert('상품 주소와 이미지 주소를 입력하세요')
      }
      else {
        alert('옷장에 추가되었습니다.')

        SiteUrl.value = ''
        ImgUrl.value = ''
      }
    }

    return {
      SiteUrl,
      ImgUrl,
      AddUrl,
      Urls,
    }
  }

}
</script>

<style scoped>
.input-style {
  margin-top: 33px;
}

.site-url {
  width: 170px;
  height: 30px;
  font-size: 15px;
}

.img-url {
  width: 170px;
  height: 30px;
  font-size: 15px;
}

.button-box {
  width: 90px;
}

button {
  width: 50px;
  height: 50px;
  border-radius: 25px;
  background-color: white;
  border: none;
}

.head-style {
  font-size: 18px;
}
</style>