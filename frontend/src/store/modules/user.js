import axios from '../../api/axios';
import { useRouter } from 'vue-router';

// 로그인 처리 관련 저장소 모듈
export const user = {
  namespaced: true,
  state: () => ({
      user_id: "",
      user_name: "",
      user_profileURI: "",
      refreshToken: "",
      isLogin: false,
  }),

  mutations: {
      SET_USER_ID: (state, user_id) => {
          state.user_id = user_id;
      },
      SET_USER_NAME: (state, user_name) => {
          state.user_name = user_name;
      },
      SET_USER_PROFILE_URI: (state, user_profileURI) => {
          state.user_profileURI = user_profileURI;
      },
      SET_REFRESH_TOKEN: (state, refreshToken) => {
        state.refreshToken = refreshToken;
      },
      SET_IS_LOGIN: (state, isLogin) => {
          state.isLogin = isLogin;
      },
    },
  getters: {
      profileURI({ user_profileURI }) {
        return user_profileURI;
      },
      userName({ user_name }) {
        return user_name;
      },
      refreshToken({ refreshToken }) {
        return refreshToken;
      },
      isLogin({ isLogin }) {
        return isLogin;
      },
      userData(state) {
        return state.user_name + ' ' + state.user_id
      },
  },
  actions: {
      setId: ({commit}, user_id) => {
          commit("SET_USER_ID", user_id);
      },
      setName: ({commit}, user_name) => {
          commit("SET_USER_NAME", user_name);
      },
      setProfileURI: ({commit}, user_profileURI) => {
          commit("SET_USER_PROFILE_URI", user_profileURI);
      },
      /* 로그아웃 */
      // async logout({ commit }) {
      // },
      /* AccessToken 갱신 요청 */
      async refreshToken({ commit }, refreshToken) {
        await axios.post("auth/refresh", refreshToken)
        .then(function (result) {
          commit("SET_REFRESH_TOKEN", result.data);
        })
        .catch(function (error) {
          console.log(error);
          const router = useRouter();
          if (error == 403) {
            // 다시 로그인하라는 메시지 출력 후 로그인으로 이동
            router.push({ name: 'Login' });
          }
        })
      }
  }
}

