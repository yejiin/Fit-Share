import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import VueCookies from 'vue3-cookies'

createApp(App).use(router).use(store).use(VueCookies,{
    expireTimes: "1d",
    path: "/",
    domain: "",
    secure: true,
    sameSite: "None",
}).mount('#app');

// Kakao developers에서 발급받은 JavaScript Key
window.Kakao.init("fa7b3aabcb61a2c3abd3809129a8ea8f");

// Naver Developers에서 발급받은 key
//"skkqxLCLHDQrwOlhytTS"
