<template>
    <div>
    <div class="col-md-auto" v-if="!encuesta">
        <tabla :title="titulo" :subTitle="subtitulo" :columns="columnas" :data="filas" @selected="verEncuesta"></tabla>
    </div>
    <div class="col-md-auto" v-if="encuesta">
        <encuesta :id="encuesta"></encuesta>
    </div>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
import tabla from '../utils/Tabla.vue'
import encuesta from './Encuesta.vue'

    export default {
      components: {
        tabla,
        encuesta
      },
      mounted () {
        this.cargarEncuestas()
      },
      data () {
        return {
          titulo: 'Encuestas',
          subtitulo: 'Lista de las encuestas actualmente creadas',
          columnas: ['Id', 'Nombre', 'Curso', 'Materia', 'Creador', 'Etapa'],
          filas: [],
          encuesta: null
        }
      },
      methods: {
        cargarEncuestas () {
          api.getEncuestasFull()
            .then(r => {
              r.forEach(e => {
                this.filas.push({
                  id: e.idEncuestas,
                  creador: e.creador,
                  curso: e.curso,
                  materia: e.materia,
                  etapa: e.etapaActual,
                  nombre: e.nombre
                })
              })
            })
        },
        verEncuesta (id) {
          this.encuesta = id
        }
      }
    }
</script>
