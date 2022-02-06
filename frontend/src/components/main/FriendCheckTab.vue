<template>
  <div>
    <div v-for="(friend, index) in state.friends" :key="friend.id" class="d-flex mt-3">
      <img :src="friend.profileImg" alt="profile-img">
      <div class="ms-3 d-flex flex-column">
        <div>
          {{ friend.id }}
        </div>
        <div class="d-flex mt-2 button-box">
          <button class="" @click="AcceptFriend(friend, index)">수락</button>
          <button class="ms-3" @click="DeclineFriend(friend, index)">거절</button>
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
    
    const AcceptFriend = async (friend, index) => {
      const res = await axios({
        method: 'POST',
        url: 'http://i6a405.p.ssafy.io:8081/api/v1/friends',
        headers: { Authorization : `Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0Iiwicm9sZXMiOiJVU0VSIiwiZXhwIjoxNjQ3NDc3NzYyfQ.tRLXFW9wHHIXCrJotone8gsjsi5Vba6zWvIQGCUtZWFrYZw3F9OaHLDeDQ9ZSOpn9E9y2OrLiDuHazuSTd4yAw` },
        data: {"friendId": friend.id}
      })
      console.log(res)
      state.friends.splice(index, 1)
        // .then(res => {
        //   console.log(res)
        //   state.friends.splice(index, 1)
        // })
   
      
      const res1 = await axios({
        method: 'DELETE',
        url: `http://i6a405.p.ssafy.io:8081/api/v1/friends/requests/${friend.id}`,
        headers: { Authorization : `Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0Iiwicm9sZXMiOiJVU0VSIiwiZXhwIjoxNjQ3NDc3NzYyfQ.tRLXFW9wHHIXCrJotone8gsjsi5Vba6zWvIQGCUtZWFrYZw3F9OaHLDeDQ9ZSOpn9E9y2OrLiDuHazuSTd4yAw` },
      })

      console.log(res1)

    
    }
    
    const DeclineFriend = (friend, index) => {
      axios({
        method: 'DELETE',
        url: `http://i6a405.p.ssafy.io:8081/api/v1/friends/requests/${friend.id}`,
        headers: { Authorization : `Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0Iiwicm9sZXMiOiJVU0VSIiwiZXhwIjoxNjQ3NDc3NzYyfQ.tRLXFW9wHHIXCrJotone8gsjsi5Vba6zWvIQGCUtZWFrYZw3F9OaHLDeDQ9ZSOpn9E9y2OrLiDuHazuSTd4yAw` }
      })
        .then(res => {
          console.log(res)
          state.friends.splice(index, 1)
        })
    }

    return {
      state,
      CheckFriendRequest,
      AcceptFriend,
      DeclineFriend
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
