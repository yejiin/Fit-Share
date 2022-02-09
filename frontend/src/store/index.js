import { createStore } from 'vuex';
import { room } from '@/store/modules/room';
import { login } from '@/store/modules/login'


export default createStore({
	modules: {
		room,
		login,
	}
});
