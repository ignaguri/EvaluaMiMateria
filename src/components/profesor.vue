<template>
    <div>
        <div class="card-header">
            <h2>Bienvenido, profesor {{nombre}}</h2>
        </div>
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <a class="navbar-brand" href="" @click.prevent="verPerfil">{{nombre}}</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav">
                        <a class="nav-item nav-link" href="" @click.prevent="verEncuestas">Encuestas <span class="sr-only">(current)</span></a>
                        <a class="nav-item nav-link" href="" @click.prevent="crearEncuesta">Crear encuesta</a>
                    </div>
                </div>
            </nav>
        <div class="container-fluid">
            <component :is="current"></component>
        </div>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../api'
import crearEncuesta from './profesores/CrearEncuesta.vue'
import listaEncuestas from './profesores/ListaEncuestas.vue'

    export default {
      props: [
        'id'
      ],
      components: {
        crearEncuesta,
        listaEncuestas
      },
      beforeRouteEnter (to, from, next) {
        next(vm => {
          const a = require('../api')
          if (!a.default.authorized(3)) {
            console.error('Usuario con permisos insuficientes')
              vm.$router.push('/')
          }
        })
      },
      data () {
        return {
          current: listaEncuestas,
          nombre: api.getNombreLogged()
        }
      },
      methods: {
        verPerfil () {
          console.log('ver perfil')
        },
        verEncuestas () {
          this.current = 'listaEncuestas'
        },
        crearEncuesta () {
          this.current = 'crearEncuesta'
        }
      }
    }
</script>
