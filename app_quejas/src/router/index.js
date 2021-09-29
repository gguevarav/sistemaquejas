import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Proveedores from '../views/Proveedores.vue'
import Quejas from '../views/Quejas.vue'
import Reportes from '../views/Reportes.vue'
import NotFound from '../views/NotFound'
import About from '../views/About.vue'

Vue.use(VueRouter)


const router = new VueRouter({
mode: 'history',
linkActiveClass: 'is-active',
routes: [{
    path: '/home',
    name: 'home',
    component: Home,
    meta: {
      requiresAuth: true,
    }
  },
  {
    path: '/',
    redirect: '/home'
  },
  {
    path: '/proveedores',
    name: 'proveedores',
    component: Proveedores,
  },
  {
    path: '/reportes',
    name: 'reportes',
    component: Reportes,
  },
  {
    path: '/404',
    name: '404',
    component: NotFound,
  },
  {
    path: '/quejas',
    name: 'quejas',
    component: Quejas,
  },
  {
    path: '*',
    redirect: '/404',
  },
  {
    path: '/about',
    name: 'about',
    component: About,
    meta: {
      requiresAuth: true,
    }
  },
]
})

export default router