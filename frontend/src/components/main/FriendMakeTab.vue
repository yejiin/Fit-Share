<template>
  <div>
    <!-- 친구 이름, 이메일 검색 input-box -->
    <input
      class="input-box"
      type="text"
      placeholder="이메일 검색"
      @keyup="SearchUserEmail"
      v-model="SearchUser"
    >
    
    <!-- 이름, 이메일로 검색 시 나오는 users들 components -->
    <!-- <searched-users :friends="state.friends"></searched-users> -->
    <searched-users :friends="state.unique"></searched-users>


  </div>
</template>

<script>
import SearchedUsers from './SearchedUsers.vue'
import { ref, reactive } from 'vue'
import axios from 'axios'
import { useCookies } from 'vue3-cookies'

export default {
  name: 'FriendMakeTab',
  components: {
    SearchedUsers,
  },
  setup() {
    const state = reactive({
      searchedUsers: [],
      exitsfriends: [],
      unique: []
    })

    const { cookies } = useCookies() 

    const setToken = () => {
      const token = cookies.get('accessToken')
      const config = {
        Authorization: `Bearer ${token}`
      }
      return config
    }

    // input에 입력하는 값
    const SearchUser = ref('');

    // input에 email 입력 시 server에 요청
    // const SearchUserEmail = () => {
    //   if (SearchUser.value) {
    //     axios({
    //       method: 'GET',
    //       url: `http://i6a405.p.ssafy.io:8081/api/v1/members/${SearchUser.value}`,
    //       headers: setToken()
    //       })
    //       .then(res => {
    //         console.log(res)
    //         state.friends = res.data.data
    //       })
    //   }
    //   else{
    //     state.friends = []
    //   }
    // }

    // test
    const SearchUserEmail = async () => {
      const friendList = await axios({
        method: 'GET',
        url: 'http://i6a405.p.ssafy.io:8081/api/v1/friends',
        headers: setToken()
      })
        .then(res => {
          console.log(res)
          state.exitsfriends = res.data.data
        })
        console.log(friendList)

      if (SearchUser.value) {
        const Users = await axios({
          method: 'GET',
          url: `http://i6a405.p.ssafy.io:8081/api/v1/members/${SearchUser.value}`,
          headers: setToken()
          })
          .then(res => {
            console.log(res)
            state.searchedUsers = res.data.data
            const ids = state.exitsfriends.map(e => e.id) // 친구 리스트 배열에서 각 객체의 id 값
            state.unique = state.searchedUsers.filter(e => !ids.includes(e.id)) // email 검색으로 나온 user 배열의 각 객체의 id와 비교하여 없는 경우에만 저장
            console.log(JSON.stringify(state.unique))
          })
          console.log(Users)
      }
      else{
        state.unique = []
      }
    }

    return {
      state,
      SearchUser,
      SearchUserEmail,
      setToken,
    }
  }
}
</script>

<style>
.result {
  text-align: center;
  font-size: 12px;
  color: #565656;
}

img {
  width: 60px;
  height: 60px;
}

.input-box {
  width: 301px;
  border-radius: 20px;
  text-align: center;
}

input::placeholder {
  text-align: center;
}
</style>