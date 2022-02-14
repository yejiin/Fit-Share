<template>
  <div>
    <div class="container">
      <div class="msg-box">
        <div :value="state.textarea"></div>
        <div v-for="msg in state.myMessage" :key="msg.createdTime">
          [나] <br>
          {{ msg.message }}
        </div>
      </div>
      <div class="inputDiv">
        <label for="message"></label>
        <input
          type="text"
          class="border-2 border-slid rounded border-gray-600 w-full inputMsg"
          id="message"
          v-model="state.message"
          @keyup.enter="sendMessage()"
          autofocus
        />
        <i class="bi bi-send" @click="sendMessage()"></i>
      </div>
    </div>
  </div>
</template>

<script>
import { reactive, computed, onMounted } from "vue";
import { useStore } from "vuex";
import { useCookies } from "vue3-cookies";
import Stomp from "stompjs";
import SockJS from "sockjs-client";

export default {
  name: 'FriendChatting',
  setup() {
    const store = useStore();
    const { cookies } = useCookies();

    onMounted(() => {
      connect();
    })

    const state = reactive({
      userName: "",
      message: "",
      textarea: "",
      connected: false,
      currentTime: "",
      myMessage: [],
    });

    state.userName = computed(() => store.state.user.user_name); // vuex에서 가져오기

    let accessToken = cookies.get("accessToken");

    let headers = {
      Authorization: "Bearer " + accessToken,
    };

    const sockJs = new SockJS("http://i6a405.p.ssafy.io:8081/api/v1/chat");
    const stomp = Stomp.over(sockJs);

    const now = () => {
      let date = new Date();
      if (date.getHours() > 12) {
        state.currentTime =
          "오후 " + (date.getHours() - 12) + ":" + date.getMinutes();
      } else {
        state.currentTime = "오전 " + date.getHours() + ":" + date.getMinutes();
      }
      return state.currentTime;
    };

    const connect = () => {
      // if (!state.connected) {
      stomp.connect(headers, (frame) => {
        state.connected = true;
        console.log("Connect Status : " + frame);
        stomp.subscribe(
          `/user/queue/messages`,
          (response) => {
            // 구독을 설정할 때, 메시지를 받으면 어떻게 처리할건지도 설정
            console.log(response);
            let receiveMsgBody = JSON.parse(response.body);
            state.textarea +=
              "[" +
              receiveMsgBody.senderName +
              "] " +
              receiveMsgBody.createdTime +
              "\n" +
              receiveMsgBody.message +
              "\n";
          },
          headers
        );
        (error) => {
          console.log("Connect Status : ", error);
          state.connected = false;
        };
      });
    };

    // 메세지를 보냈을 때
    const sendMessage = () => {
      // message의 값이 있고 연결된 상태라면
      if (state.message !== "" && state.connected) {
        let sendMsg = {
          senderName: state.userName,
          message: state.message,
          createdTime: now(),
        };
        console.log(sendMsg.createdTime)
        stomp.send(`/app/messages`, headers, JSON.stringify(sendMsg));
        state.myMessage.push(sendMsg)
        state.message = "";
      }
    };

    return {
      state, stomp, headers,
      now, connect, sendMessage,
    }
  }
}
</script>

<style>
.container {
  width: 387px;
  height: 464px;
  border: 1px solid black;
  background-color: #fdfaf3;
}

/* .inputDiv {
  position: relative;
} */

i {
  position: fixed;
  left: 69%;
  top: 95%;
}

.inputMsg {
  width: 360px;
  height: 40px;
  position: fixed;
  top: 94%;
}

.msg-box {
  width: 100%;
  height: 85%;
  overflow-y: scroll;
  background-color: white;
}

.msg-box::-webkit-scrollbar {
  width: 7px;
  /* background-color: beige; */
}
.msg-box::-webkit-scrollbar-thumb {
  background-color: #2f3542;
  border-radius: 10px;
}
.msg-box::-webkit-scrollbar-track {
  background-color: #FDFAF3;
  border-radius: 10px;
  box-shadow: inset 0px 0px 5px white;
}
</style>