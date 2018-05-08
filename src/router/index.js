import Vue from 'vue'
import Router from 'vue-router'
import landing from '@/components/landing'
import login from '@/components/login'
import admin from '@/components/admin'
import registrar from '@/components/registrar'
import alumno from '@/components/alumno'
import profesor from '@/components/profesor'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Landing',
      component: landing
    },
    {
      path: '/login',
      name: 'Login',
      component: login
    },
    {
      path: '/admin',
      name: 'Admin',
      component: admin
    },
    {
      path: '/registrar',
      name: 'Registrar',
      component: registrar
    },
    {
      path: '/alumno/:id',
      name: 'Alumno',
      component: alumno,
      props: true
    },
    {
      path: '/profesor/:id',
      name: 'Profesor',
      component: profesor,
      props: true
    }
  ]
})
