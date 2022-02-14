<template>
  <div>
    <div class="container">
      <div class="msg-box">
        <div>
          {{ state.textarea }}
        </div>

        <!-- test -->
        <!-- <div v-for="msg in state.testMessage" :key="msg.createdTime" class="friend-msg-box">
          <div class="mt-2 friend-name" align="right">
            [{{ msg.username }}] {{ msg.createdTime }} <br/>
          </div>
          <div class="friend-msg rounded mt-1">
            {{ msg.Message }}
          </div>
        </div> -->

        <!-- 내 메시지 -->
        <div v-for="msg in state.myMessage" :key="msg.createdTime" class="my-msg-box">
          <div class="mt-2">
            [나] {{ dateFormatChange(msg.createdTime) }} <br/>
          </div>
          <div class="my-msg rounded mt-1">
            {{ msg.message }}
          </div>
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
      testMessage: [
        { Message: '하이하이', createdTime: 'dddd', username: 'test' },
        { Message: '하이하', createdTime: 'ssss', username: 'test1' }
      ]
    });

    state.userName = computed(() => store.state.user.user_name); // vuex에서 가져오기

    let accessToken = cookies.get("accessToken");

    let headers = {
      Authorization: "Bearer " + accessToken,
    };

    const sockJs = new SockJS("http://i6a405.p.ssafy.io:8081/api/v1/chat");
    const stomp = Stomp.over(sockJs);

    const dateFormatChange = (date) => {
      let changedDate = new Date(date);
      // console.log(changedDate.getHours() + changedDate.getMinutes());
      if (changedDate.getHours() > 12) {
        return (
          "오후 " +
          pad(changedDate.getHours() - 12) +
          ":" +
          pad(changedDate.getMinutes())
        );
      } else {
        return (
          "오전 " + pad(changedDate.getHours()) + ":" + pad(changedDate.getMinutes())
        );
      }
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
              dateFormatChange(receiveMsgBody.createdTime) +
              "\n" +
              receiveMsgBody.message +
              "\n";
          },
          console.log('aptlwl'),
          console.log(state.textarea),
          headers
        );
        (error) => {
          console.log("Connect Status : ", error);
          state.connected = false;
        };
      });
    };

    const koreaTime = () => {
      const now = new Date();
      let temp =
        now.getFullYear() +
        "-" +
        pad(now.getMonth() + 1) +
        "-" +
        pad(now.getDate()) +
        "T" +
        pad(now.getHours()) +
        ":" +
        pad(now.getMinutes()) +
        ":" +
        pad(now.getSeconds()) +
        "." +
        (now.getMilliseconds() / 1000).toFixed(3).slice(2, 5) +
        "Z";
      return temp;
    };

    const pad = (number) => {
      if (number < 10) {
        return "0" + number;
      }
      return number;
    };

    // 메세지를 보냈을 때
    const sendMessage = async () => {
      // message의 값이 있고 연결된 상태라면
      if (state.message !== "" && state.connected) {
        let sendMsg = {
          senderName: state.userName,
          message: state.message,
          createdTime: koreaTime(),
        };
        await stomp.send(
          `/app/messages`, headers, JSON.stringify(sendMsg)
        )
        console.log(sendMsg.createdTime)
        state.myMessage.push(sendMsg)
        state.message = "";
      }
    };

    return {
      state, stomp, headers,
      dateFormatChange, connect, sendMessage,
    }
  }
}
</script>

<style scoped>
.container {
  width: 387px;
  height: 464px;
  border: 1px solid black;
  background-color: #fdfaf3;
}

.inputDiv {
  position: relative;
}

i {
  position: absolute;
  left: 90%;
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
  background-color: #fdfaf3;
}

.msg-box::-webkit-scrollbar {
  /* width: 7px; */
  display: none;
}
/* .msg-box::-webkit-scrollbar-thumb {
  background-color: #2f3542;
  border-radius: 10px;
}
.msg-box::-webkit-scrollbar-track {
  background-color: #FDFAF3;
  border-radius: 10px;
  box-shadow: inset 0px 0px 5px white;
} */

.my-msg-box {
  width: 70%;
}

.my-msg {
  /* width: 100%; */
  /* background-color: #D3E2E7; */
  /* background-color: #E5EBF7; */
  /* background-color: #EFEFEF; */
  background-color: #FFBDBD;
}

/* .friend-msg-box {
  width: 70%;
} */

.friend-msg {
  width: 70%;
  margin-left: 30%;
  background-color: #E5EBF7;
  text-align: right;
}
</style>