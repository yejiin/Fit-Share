<template> 
  <div id="session">
    <div id="session" class="" v-if="session">
      <!-- 화상화면 -->
			<div id="video-container" class="d-flex flex-row">
        <room-video :stream-manager="publisher" @click="updateMainVideoStreamManager(publisher)"/>
        <room-video v-for="sub in subscribers" :key="sub.stream.connection.connectionId" :stream-manager="sub" @click="updateMainVideoStreamManager(sub)"/>
      </div>
      <!-- <div id="main-video" class="col-md-6">  
				<user-video :stream-manager="mainStreamManager"/>
			</div> -->

      <!-- 나머지 컴포넌트 -->
      <div class="components-container d-flex flex-row">
        <group-chat class="group-chat"></group-chat>
        <div>
          <shopping-site class="shopping-site"></shopping-site>
          <!-- 화상회의 버튼 -->
          <div class="buttons">
            <button v-if="isAudio" class="btn shadow-none" @click="offAudio()"><i class="bi bi-mic-mute-fill"></i></button>
            <button v-if="!isAudio" class="btn shadow-none" @click="onAudio()"><i class="bi bi-mic-fill"></i></button>
            <button v-if="isVideo" class="btn shadow-none" @click="offVideo()"><i class="bi bi-camera-video-off-fill"></i></button>
            <button v-if="!isVideo" class="btn shadow-none" @click="onVideo()"><i class="bi bi-camera-video-fill"></i></button>
            <input class="btn shadow-none" type="button" id="buttonLeaveSession" @click="leaveSession" value="나가기">
          </div>
        </div>
        <closet class="closet"></closet>
      </div>
		</div>
  </div>
</template>

<script>
import { reactive, toRefs } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import axios from 'axios';
import { OpenVidu } from 'openvidu-browser';
import RoomVideo from '@/components/room/RoomVideo.vue';
import ShoppingSite from '@/components/room/ShoppingSite.vue';
import Closet from '@/components/room/Closet.vue';
import GroupChat from '@/components/room/GroupChat.vue';

axios.defaults.headers.post['Content-Type'] = 'application/json';   

// const OPENVIDU_SERVER_URL = "https://" + location.hostname + ":4443";
// const OPENVIDU_SERVER_SECRET = "MY_SECRET";


export default {
    name: 'ShoppingRoom',

    components: {
      RoomVideo, ShoppingSite, Closet, GroupChat
    },

    setup () {
        const router = useRouter()
        const route = useRoute()

        const state = reactive({
          OV: undefined,
          session: undefined,
          mainStreamManager: undefined,
          publisher: undefined,  
          subscribers: [], 

          mySessionId: '',
          myUserName: '',

          isAudio: false,
          isVideo: false,

          token: '',
        })

        // created 
        state.mySessionId = route.params.roomId  
        state.myUserName = route.params.myUserName  // store에서 사용자이름 가져오기 
        
        state.token = route.params.token  // 토큰 저장관련 이슈!!!!!
        
        // methods        
        const goToMain = () => {
          router.push({ name: 'Main' })
        }
        
        const offAudio = () => {
          state.publisher.publishAudio(state.isAudio)
          state.isAudio = false
        }
        const onAudio = () => {
          state.publisher.publishAudio(state.isAudio)
          state.isAudio = true
        }

        const offVideo = () => {
          state.publisher.publishVideo(state.isVideo)
          state.isVideo = false
        }
        const onVideo = () => {
          state.publisher.publishVideo(state.isVideo)
          state.isVideo = true
        }

        // openvidu method
        const joinSession = () => {
          state.OV = new OpenVidu();

          state.session = state.OV.initSession();

          state.session.on('streamCreated', ({ stream }) => {
            const subscriber = state.session.subscribe(stream);
            state.subscribers.push(subscriber);
          });

          state.session.on('streamDestroyed', ({ stream }) => {
            const index = state.subscribers.indexOf(stream.streamManager, 0);
            if (index >= 0) {
              state.subscribers.splice(index, 1);
            }
          });

          state.session.on('exception', ({ exception }) => {
            console.warn(exception);
          });
          
          // ------------- token 관련 method -----------------

          state.session.connect(state.token, { clientData: state.myUserName })
            .then(() => {
              let publisher = state.OV.initPublisher(undefined, {
                  audioSource: undefined, 
                  videoSource: undefined,
                  publishAudio: true,  	
                  publishVideo: true,  	
                  resolution: '640x480',  
                  frameRate: 30,			
                  insertMode: 'APPEND',	
                  mirror: false       	
                });
                
                state.mainStreamManager = publisher;
                state.publisher = publisher;

                // --- Publish your stream ---
                state.session.publish(state.publisher);
            })
            .catch(error => {
                console.log('There was an error connecting to the session:', error.code, error.message);
            });

          window.addEventListener('beforeunload', leaveSession)
        }

        // token method 
        // function getToken (sessionId) {
        //   axios({
        //     method: 'get',
        //     url: 'get-api',
        //     data: { roomId: sessionId }
        //   })
        //     .then(res => res.data.token)
        //     .catch(err => console.log(err))
        // }

        // created
        joinSession() 

        const leaveSession = () => {
          if (state.session) state.session.disconnect();

          state.session = undefined;
          state.mainStreamManager = undefined;
          state.publisher = undefined;
          state.subscribers = [];
          state.OV = undefined;

          window.removeEventListener('beforeunload', leaveSession);
          goToMain()

        }

        const updateMainVideoStreamManager = (stream) => {  // 화상화면 클릭시 해당 화면이 메인으로 이동 
          if (state.mainStreamManager === stream) return;
          state.mainStreamManager = stream;
        }

        return { 
          // goToCreate,
          goToMain, offAudio, offVideo, onAudio, onVideo,
          joinSession, 
          // getToken, createSession, createToken, 
          leaveSession, updateMainVideoStreamManager,
          ...toRefs(state)
        }
    }

}
</script>

<style scoped>
#session {
  background-color: #D3E2E7;
}

#video-container {
  justify-content: center;
  background-color: #D3E2E7;
  height: 185px;
}

.video-row {
  flex-direction: row;
}

.components-container {
  display: flex;
  justify-content: space-between;
  /* position: relative; */
}

.group-chat, .closet {
  width: 290px;
  height: 839px;
  background-color: white;
}

.shopping-site {
  height: 780px
}

.buttons {
  height: 70px;
  line-height: 70px;
  text-align: center;
}

/* 확인! */
.buttons .btn {  
  margin: 0 5px 0;
  cursor: pointer;
}

.buttons #buttonLeaveSession {
  background-color: red;
  color: white;
  margin-left: 15px;
}

i {
  font-size: 26px;
}
</style>