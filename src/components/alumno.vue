<template>
    <div class="row">
<h1>PAGINA DE ALUMNOS</h1>
        <h2>El id es {{id}}</h2>
    </div>
</template>
<script>
/* eslint-disable indent */
// import api from '../api'
    export default {
      props: [
        'id'
      ],
      beforeRouteEnter (to, from, next) {
        next(vm => {
          const a = require('../api')
          if (!a.default.authorized(2)) {
            console.error('Usuario con permisos insuficientes')
            vm.$router.push('/')
          }
        })
      },
      data () {
        return {
        }
      },
      methods: {
      }
    }
</script>
