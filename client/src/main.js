import Vue from 'vue'
import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'
import App from './App.vue'
import store from './store/store'
import router from './router/router'
import vuetify from '@/plugins/vuetify' 

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
  store,
  router,
  vuetify
}).$mount('#app')
