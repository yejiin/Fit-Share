<template>
  <div>
    <div v-if="friend.profileImg" class="text-center result-box mt-3">
      검색 결과
    </div>
    <div class="d-flex mt-3" v-if="friend.profileImg">
      <img :src="friend.profileImg" alt="profile-img">
      <div class="ms-3 profile-box name-box">
        {{ friend.name }}
      </div>
      <div class="d-flex align-self-center btn-box justify-content-center">
        <button class="plus-btn" @click="RequestFriend(friend)">
          +
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { useCookies } from 'vue3-cookies'

export default {
  name: 'SearchedUsers',
  props: ['friend'],
  setup(props) {
    
    const { cookies } = useCookies() 

    const setToken = () => {
      const token = cookies.get('accessToken')
      const config = {
        Authorization: `Bearer ${token}`
      }
      return config
    }

    console.log('props 데이터')
    console.log(props.friend)

    // 친구 요청 post
    const RequestFriend = (friend) => {
      axios({
        method: 'POST',
        url: 'http://i6a405.p.ssafy.io:8081/api/v1/friends/requests',
        headers: setToken(),
        data: {"friendId": friend.id}
      })
      .then(res => {
        console.log(res)
      })
      friend.profileImg = null 
    }

    return {
      RequestFriend,
      setToken,
    }
  }
}
</script>

<style scoped>
.input-box {
  width: 301px;
  border-radius: 20px;
  text-align: center;
}

input::placeholder {
  text-align: center;
}

.result-box {
  font-size: 12px;
  color: '#565656'
}

.profile-box {
  width: 180px;
}

/* user 이름 font-size */
.name-box {
  font-size: 20px;
}

img {
  width: 50px;
  height: 50px;
  border-radius: 25px;
}

.plus-btn {
  width: 40px;
  height: 40px;
  border-radius: 25px;
  background-color: #FDFAF3;
}

.btn-box {
  width: 50px;
}

</style>