<template>
  <div class="room-container">
   <h2>Live</h2>
   <div class="row">
     <div class="room col-6" :class="index % 2 ? 'room-right' : 'room-left'" v-for="(room, index) in shoppingRoomList" :key="index">
       <div class="room-info">
        <p class="mall-name">{{ room.shoppingMallName }}</p>
        <p class="host-name">{{ room.hostName }}님이 쇼핑중</p>
       </div>
     </div>
   </div>
  </div>
</template>

<script>
import { reactive, toRefs } from 'vue';

export default {
    name: 'ShoppingRoomList',
    
    setup() {
      const state = reactive({
        shoppingRoomList : [
          { shoppingRoomId: 1, hostName: '김싸피', shoppingMallId: 1, shoppingMallName: 'nike', shoppingMallUrl: '..', password: 1234 },  // 이 외에 추가적으로
          { shoppingRoomId: 2, hostName: '이싸피', shoppingMallId: 2, shoppingMallName: '지그재그', shoppingMallUrl: '..'},
          { shoppingRoomId: 3, hostName: '최싸피', shoppingMallId: 1, shoppingMallName: '홈', shoppingMallUrl: '..'},
          { shoppingRoomId: 4, hostName: '박싸피', shoppingMallId: 1, shoppingMallName: '쇼핑몰', shoppingMallUrl: '..'},
          { shoppingRoomId: 5, hostName: '...', shoppingMallId: 1, shoppingMallName: '쇼핑몰2', shoppingMallUrl: '..'},
        ],

      })

      // methods
      function getShoppingRoomList () {
        // axios({
        //   method: 'get',
        //   url: '쇼핑룸 목록 API',
        // })
        //   .then(res => {
        //     state.shoppingRoomList = res.data
        //   })

      }

      // created
      // getShoppingRoomList()

      return {
        ...toRefs(state), getShoppingRoomList,
      }
    }
}
</script>

<style scoped>
.room-container {
  height: 775px;
  width: 543px;
  background-color: #FDFAF3;
  /* padding: 30px, 43px, 48px; */
}

h2 {
  font-size: 20px;
  font-weight: bold;
  padding: 30px 43px;
  margin: 0;
  /* margin: 30px 43px; */
}

.row {
  width: 543px;
  height: 691px;
  overflow-y: scroll;
  padding: 0 43px 0 43px;
  margin: 0;
}

.row::-webkit-scrollbar {
  width: 7px;
}
.row::-webkit-scrollbar-track {
  background-color: transparent;
}
.row::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background-color: #D3E2E7;
}

.room {
  position: relative;
  padding: 0;
  margin-bottom: 45px;
  width: 205px;
  height: 297px;  
  border-radius: 10px;

  /* background-image: url('../../assets/shop_bg.jpg');
  background-repeat: no-repeat;
  background-size: 100%; */

  background-image: url('../../assets/shopping.png');
  background-repeat : no-repeat;
  background-size : contain;
  background-position: 0 14px;

  /* background-position: center center; */
}

.room-left {
  margin-right: 20px;
}
.room-right {
  margin-left: 20px;
}

.room-info {
  position: absolute;
  bottom: 0;
}

p {
  font-size: 16px;
  font-weight: bold;
}
.mall-name {
  margin: 0 23px 11px;
}
.host-name {
  margin: 0 23px 18px;
}
</style>