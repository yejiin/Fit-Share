<template>
  <div id="closet">
  
    <div class="accordion" id="accordionExample">
      <div class="accordion-item" v-for="(friend, index) in friends" :key="friend.id">
        <h2 class="accordion-header" :id="'heading'+friend.id">
          <button class="accordion-button" :class="{ 'collapsed': index !== 0 }" type="button" data-bs-toggle="collapse" :data-bs-target="'#collapse'+friend.id" aria-expanded="true" :aria-controls="'collapse'+friend.id" v-if="friend.id === 1">
            내 옷장
          </button>
          <button class="accordion-button" :class="{ 'collapsed': index !== 0 }" type="button" data-bs-toggle="collapse" :data-bs-target="'#collapse'+friend.id" aria-expanded="true" :aria-controls="'collapse'+friend.id" v-if="friend.id != 1" @click="getClothes">
            {{ friend.name }}
          </button>
        </h2>
        <div :id="'collapse'+friend.id" class="accordion-collapse collapse" :class="{ 'show': index === 0 }" :aria-labelledby="'heading'+friend.id" data-bs-parent="#accordionExample">
          <div class="accordion-body" v-if="friend.id === 1">
            <div class="d-flex input-style">
              <input type="text" placeholder="이미지 Url 입력" class="img-url mt-1" v-model="ImgUrl">
              <!-- <button @click="AddUrl" class="add-button ms-3">
                  +
              </button> -->
              <img src="@/assets/plus_icon.png" @click="AddUrl" alt="" class="plus-img ms-3">
            </div>
            <div class="img-box">
              <div v-for="friend in friends" :key="friend.id">
                <button class="btn btn-secondary" @click="$emit('fitting', friend.src)">입어보기</button>
                <img :src="friend.src" alt="img" class="img-style">
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>


  </div>
</template>

<script>
import { ref, reactive } from 'vue'
import axios from 'axios'
import { useCookies } from 'vue3-cookies'

export default {
  name: 'Closet',
  components: {
    
  },
  props: {
    subscribers: Object,
    mySessionId: String,
    mainStreamManager: Object,
  },
  emits: ['fitting'],
  setup(props) {
    const friends = ref([
      // {id:1, name: '김싸피', src: require('@/assets/shirt.jpg')},
      {id:1, name: '김싸피', src: 'https://image.msscdn.net/images/goods_img/20200407/1388147/1388147_3_500.jpg'},
 
    ])

    console.log(props.mySessionId)
    console.log('publisher')
    console.log(props.mainStreamManager)
    console.log('publisher')


    const ImgUrl = ref('')
    
    const Urls = ref('')

    const state = reactive({
      clothes: [],
    })

    const { cookies } = useCookies() 

    const setToken = () => {
      const token = cookies.get('accessToken')
      const config = {
        Authorization: `Bearer ${token}`
      }
      return config
    }


    const AddUrl = () => {
      if(ImgUrl.value.length < 1) {
        alert('이미지 주소를 입력하세요')
      }
      else {
        alert('옷장에 추가되었습니다.')
        axios({
          method: 'POST',
          url: `http://i6a405.p.ssafy.io:8081/api/v1/clothes`,
          headers: setToken(),
          data: {"imageUrl": ImgUrl.value, "shoppingRoomId": props.mySessionId}
          })
          .then(res => {
            console.log('hi')
            console.log(res)
            // state.clothes = res.data.data
            // friends.value = res.data.data
          })
        ImgUrl.value = ''
      }
    }

    const getClothes = () => {
      axios({
        method: 'GET',
        url: `http://i6a405.p.ssafy.io:8081/api/v1/clothes/${props.mySessionId}/8`,
        headers: setToken(),
      })
      .then(res => {
        console.log(res)
        friends.value = res.data.data
      })
    }

    const fitting = () => {

    }

    return {
      friends,
      ImgUrl,
      AddUrl,
      Urls,
      fitting,
      setToken,
      getClothes,
      state
    }
  }
}
</script>

<style scoped>
#closet {
  border: solid black;
}

.head-style {
  font-size: 24px;
}

.input-style {
  margin-top: 33px;
}

.site-url {
  width: 170px;
}

.img-url {
  width: 170px; 
}

/* 버튼 사용 시 스타일 */
/* .add-button {
  background-color: white;
  border: none;
} */

/* 버튼모양 이미지로 대체했을 때 스타일 */
.plus-img {
  width: 40px;
  height: 40px;
}

.head-style {
  font-size: 18px;
}

.img-style {
  width: 200px;
  height: 200px;
}

.img-box .btn {
  position: relative;
  left: 110px;
  top: 200px;
}

.img-box {
  height: 463px;
  overflow-y: scroll;
  overflow-x: hidden;
  position: relative;
}

.img-box::-webkit-scrollbar {
  width: 10px;
}
.img-box::-webkit-scrollbar-thumb {
  background-color: #2f3542;
  border-radius: 10px;
}
.img-box::-webkit-scrollbar-track {
  background-color: #FDFAF3;
  border-radius: 10px;
  box-shadow: inset 0px 0px 5px white;
}
</style>