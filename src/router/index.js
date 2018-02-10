import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import login from '@/components/login'
import materias from '@/components/materias'
import registrar from '@/components/registrar'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/login',
      name: 'Login',
      component: login
    },
    {
      path: '/materias',
      name: 'Materias',
      component: materias
    },
    {
      path: '/registrar',
      name: 'Registrar',
      component: registrar
    }
  ]
})
