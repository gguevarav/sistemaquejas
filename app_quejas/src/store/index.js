import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import router from "@/router";
import {bus} from "@/main";

//axios.defaults.withCredentials = true;
axios.defaults.baseURL ="http://172.31.2.85:8000"

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    token: localStorage.getItem('access_token') || null,
    datos: null,
    NombreUsuario: null,
    CorreoUsuario: null,
  },
  getters:{
    loggedIn(state){
      return state.token !== null
    }
  },
  mutations: {
    
  },
  actions: {
    retrieveToken(context, credentials) {

      return new Promise((resolve, reject) => {
        axios.post('/api/auth/login', {
          email: credentials.username,
          password: credentials.password,
        })
          .then(response => {
            //console.log(response)
            const token = response.data.access_token
            localStorage.setItem('access_token', 'Bearer ' + token)
            //localStorage.setItem()
            context.commit('retrieveToken', token)
            //this.obtenerInformacionUsuario(credentials);
            resolve(response)
          })
          .catch(error => {
            //console.log(error)
            reject(error)
          })
      });

    },

    

    destroyToken(context) {
      
      if (context.getters.loggedIn){
        
        return new Promise((resolve, reject) => {
          axios.post('/api/auth/logout', '', {
              headers: { Authorization: 'Bearer ' + context.state.token }
            })
            .then(response => {
              //console.log(response)
              localStorage.removeItem('access_token')
              localStorage.removeItem('idUsuario')
              localStorage.removeItem('NombreUsuario')
              localStorage.removeItem('CorreoUsuario')
              localStorage.removeItem('idRol')
              localStorage.removeItem('NombreRol')
              localStorage.clear();
              bus.$emit('logged', 'User logged');
              router.push({ name: "login" });
              context.commit('destroyToken')
  
              resolve(response)
            })
            .catch(error => {
              //console.log(error)
              localStorage.removeItem('access_token')
              localStorage.removeItem('idUsuario')
              localStorage.removeItem('NombreUsuario')
              localStorage.removeItem('CorreoUsuario')
              localStorage.removeItem('idRol')
              localStorage.removeItem('NombreRol')
              localStorage.clear();
              bus.$emit('logged', 'User logged');
              router.push({ name: "login" });
              context.commit('destroyToken')

              reject(error)
            })
        })
      }
    },

    // Color por status de actividad
    colorEstadoActividad(context, estado){
      var color = '';
      if(estado.NombreEstado == 'Activo'){
        color = 'red';
      }else if(estado.NombreEstado == 'En proceso'){
        return 'yellow';
      }else if(estado.NombreEstado == 'Cerrado') {
        return 'green';
      }
      context.commit('colorEstadoActividad', color);
    }
  },
  modules: {
  }
})
