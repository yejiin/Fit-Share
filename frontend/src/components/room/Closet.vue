<template>
  <div id="closet">
  
    <div class="accordion" id="accordionExample">
      <!-- <div class="accordion-item" v-for="(friend, index) in friends" :key="friend.id">
        <h2 class="accordion-header" :id="'heading'+friend.id">
          <button class="accordion-button" :class="{ 'collapsed': index !== 0 }" type="button" data-bs-toggle="collapse" :data-bs-target="'#collapse'+friend.id" aria-expanded="true" :aria-controls="'collapse'+friend.id" v-if="friend.id === 1">
            내 옷장
          </button>
          <button class="accordion-button" :class="{ 'collapsed': index !== 0 }" type="button" data-bs-toggle="collapse" :data-bs-target="'#collapse'+friend.id" aria-expanded="true" :aria-controls="'collapse'+friend.id" v-if="friend.id != 1">
            {{ friend.name }}
          </button>
        </h2>
        <div :id="'collapse'+friend.id" class="accordion-collapse collapse" :class="{ 'show': index === 0 }" :aria-labelledby="'heading'+friend.id" data-bs-parent="#accordionExample">
          <div class="accordion-body" v-if="friend.id === 1">
            <div class="d-flex input-style">
              <input type="text" placeholder="이미지 Url 입력" class="img-url mt-1" v-model="ImgUrl">
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
      </div> -->

      <!-- test -->
      <!-- <div class="accordion-item" v-for="(subscribe, index) in subscribers" :key="index">
        <h2 class="accordion-header" :id="'heading'+index">
          <button class="accordion-button" :class="{ 'collapsed': index !== 0 }" type="button" data-bs-toggle="collapse" :data-bs-target="'#collapse'+index" aria-expanded="true" :aria-controls="'collapse'+index">
            {{ splitName(subscribe).split(' ')[0] }}
            {{ splitName(subscribe).split(' ')[1] }}
          </button>
        </h2>
        <div :id="'collapse'+index" class="accordion-collapse collapse" :class="{ 'show': index === 0 }" :aria-labelledby="'heading'+index" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <div class="d-flex input-style">
              <input type="text" placeholder="이미지 Url 입력" class="img-url mt-1" v-model="ImgUrl">
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
      </div> -->

      <!-- publisher(내 옷장) -->
      <div class="accordion-item" v-for="(subscribe, index) in subscribers" :key="index">
        <h2 class="accordion-header" :id="'heading'+index">
          <button class="accordion-button" :class="{ 'collapsed': index !== 0 }" type="button" data-bs-toggle="collapse" :data-bs-target="'#collapse'+index" aria-expanded="true" :aria-controls="'collapse'+index">
            {{ splitName(subscribe).split(' ')[0] }} 's 옷장
          </button>
        </h2>
        <div :id="'collapse'+index" class="accordion-collapse collapse" :class="{ 'show': index === 0 }" :aria-labelledby="'heading'+index" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <div class="img-box">
              <div v-for="friend in friends" :key="friend.id">
                <button class="btn btn-secondary" @click="$emit('fitting', friend.src)">입어보기</button>
                <img :src="friend.src" alt="img" class="img-style">
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- subscribers(자신 제외 사람 옷장) -->
      <div class="accordion-item" v-for="(subscribe, index) in subscribers" :key="index">
        <h2 class="accordion-header" :id="'heading'+index">
          <button class="accordion-button" :class="{ 'collapsed': index !== 0 }" type="button" data-bs-toggle="collapse" :data-bs-target="'#collapse'+index" aria-expanded="true" :aria-controls="'collapse'+index">
            {{ splitName(subscribe).split(' ')[0] }} 's 옷장
          </button>
        </h2>
        <div :id="'collapse'+index" class="accordion-collapse collapse" :class="{ 'show': index === 0 }" :aria-labelledby="'heading'+index" data-bs-parent="#accordionExample">
          <div class="accordion-body">
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
    
    <button @click="getPublisher">publisher</button>
    <button @click="getClothes">클릭</button>
    <div v-for="cloth in state.clothes" :key="cloth.id">
      <img :src="cloth.imagePath" alt="" class="clth-style">
    </div>

  </div>
</template>

<script>
import { ref, reactive, computed } from 'vue'
import axios from 'axios'
import { useCookies } from 'vue3-cookies'
import { useStore } from 'vuex'

export default {
  name: 'Closet',
  components: {
    
  },
  props: {
    subscribers: Object,
    mySessionId: String,
    publisher: Object,
  },
  emits: ['fitting'],
  setup(props) {
    const friends = ref([
      // {id:1, name: '김싸피', src: require('@/assets/shirt.jpg')},
      {id:1, name: '김싸피', src: 'https://image.msscdn.net/images/goods_img/20200407/1388147/1388147_3_500.jpg'},
      {id:2, name: '최싸피', src: 'https://image.msscdn.net/images/goods_img/20200407/1388147/1388147_3_500.jpg'},
    ])

    console.log(props.mySessionId)

    const ImgUrl = ref('')
    
    const Urls = ref('')

    const state = reactive({
      clothes: [],
      subscribers: [],
      clientData: computed(() => {
        const { clientData } = getConnectionData();
        return clientData.split(' ')[1]
      }),
    })

    console.log(props.subscribers)

    // publisher data 객체만 추출
    const getConnectionData = () => {
      const { connection } = props.publisher.stream
      return JSON.parse(connection.data);
    }

    // test
    const splitName = (subscribe) => {
      const { connection } = subscribe.stream
      const parse = JSON.parse(connection.data)
      const { clientData } =  parse
      return clientData
    }

    const { cookies } = useCookies() 

    const store = useStore()

    const setToken = () => {
      const token = cookies.get('accessToken')
      const config = {
        Authorization: `Bearer ${token}`
      }
      return config
    }
    
    // 내 id store/login 에서 가져오기
    const myId = computed(() => {
      return store.state.login.user_id
    })
    console.log(myId.value)

    // 옷 이미지 주소 입력 후 등록
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
            console.log(res)
            // state.clothes = res.data.data
            friends.value = res.data.data
          })
        ImgUrl.value = ''
      }
    }

    // mySessionId 번 방의 memberId 의 옷 리스트 GET 요청
    const getClothes = () => {
      axios({
        method: 'GET',
        url: `http://i6a405.p.ssafy.io:8081/api/v1/clothes/${props.mySessionId}/8`,
        headers: setToken(),
      })
      .then(res => {
        console.log(res)
        // friends.value = res.data.data
        state.clothes = res.data.data
        console.log(state.clothes)
      })
    }

    const fitting = () => {

    }

    // test
    const getPublisher = () =>{
      console.log(state.clientData)
    }

    return {
      friends,
      ImgUrl,
      AddUrl,
      Urls,
      fitting,
      setToken,
      getClothes,
      state,
      getPublisher,
      myId,
      getConnectionData, splitName
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

.clth-style {
  width: 300px;
  height: 300px;;
}
</style>