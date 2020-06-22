export default ({
    state: {
        isLogged: false
    },
    getters: {
        isLogged(state) {
            return state.isLogged
        }
    },
    mutations: {
        setLogged(state, newValue) {
            state.isLogged = newValue;
        }
    },
    actions: {
        changeLogged(context, value) {
            context.commit('setLogged', value);
        }
    }

})