import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify';
// Barra de Navegación
import BarraNavegacion from './components/NavigationBar';

// Nombres componentes
// Barra de navegación
Vue.component('BarraNavegacion', BarraNavegacion);

Vue.config.productionTip = false

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
