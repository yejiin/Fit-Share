<template>
  <div>
    <div v-for="friend in state.friends" :key="friend.id" class="d-flex mt-3">
      <img :src="friend.src" alt="profile-img">
      <div class="ms-3 d-flex flex-column">
        <div>
          {{ friend.id }}
        </div>
        <div class="d-flex mt-2 button-box">
          <button class="">수락</button>
          <button class="ms-3">거절</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { reactive } from 'vue'
import axios from 'axios'

export default {
  name: 'FriendCheckTab',
  setup() {
    // const friends = ref([
    //   {id: 1, name: '김싸피', src: require('@/assets/friend_icon.png')},
    //   {id: 2, name: '김싸피', src: require('@/assets/friend_icon.png')},
    //   {id: 3, name: '김싸피', src: require('@/assets/friend_icon.png')},
    //   {id: 4, name: '김싸피', src: require('@/assets/friend_icon.png')},
    //   {id: 5, name: '김싸피', src: require('@/assets/friend_icon.png')},
    //   {id: 6, name: '김싸피', src: require('@/assets/friend_icon.png')}
    // ])

    const state = reactive({
      friends: [],
    })


    function CheckFriendRequest() {
      axios({
        method: 'GET',
        url: 'http://i6a405.p.ssafy.io:8081/api/v1/friends/requests',
        headers: { Authorization : `Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0Iiwicm9sZXMiOiJVU0VSIiwiZXhwIjoxNjQ3NDc3NzYyfQ.tRLXFW9wHHIXCrJotone8gsjsi5Vba6zWvIQGCUtZWFrYZw3F9OaHLDeDQ9ZSOpn9E9y2OrLiDuHazuSTd4yAw` }
      })
        .then(res => {
          console.log(res)
          state.friends = res.data.data
        })
    }

    CheckFriendRequest()    

    return {
      // friends,
      state,
      CheckFriendRequest
    }
  }
}
</script>

<style scoped>
.button-box {
  font-size: 12px;
}

.button-box > button {
  background: #FDFAF3;
  font-size: 12px;
  border-radius: 15px;
  width: 90px;
}
</style>