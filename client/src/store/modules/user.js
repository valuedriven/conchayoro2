const LOGIN = "LOGIN";
const LOGIN_SUCCESS = "LOGIN_SUCCESS";
const LOGOUT = "LOGOUT";

export default ({
    state: {
        isLogged: !!localStorage.getItem('token'),
        username: ''

    },
    getters: {
        isLogged: state => {
          return state.isLogged
         },
         getUsername: state => {
          return state.username
         }
    },
    mutations: {
        [LOGIN](state) {
            state.pending = true;            
        },
        [LOGIN_SUCCESS](state, username) {
            state.isLogged = true;
            state.pending = false;
            state.username = username;
        },
        [LOGOUT](state) {
            state.isLogged = false;
            state.username = '';
        }
    },
    actions: {
        login({ commit }, credentials ) {
          commit(LOGIN);
          return new Promise(resolve => {
            setTimeout(() => {
              localStorage.setItem("token", "JWT");
              commit(LOGIN_SUCCESS, credentials.username);
              resolve();
            }, 1000);
          });
        },
        logout({ commit }) {
          localStorage.removeItem("token");
          commit(LOGOUT);
        }
      }
})