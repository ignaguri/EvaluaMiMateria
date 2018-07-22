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
          subtitulo: 'Lista de las encuestas a la que estás matriculado',
          columnas: ['Id', 'Nombre', 'Curso', 'Materia', 'Creador', 'Etapa'],
          filas: [],
          encuesta: null
        }
      },
      watch: {
        encuesta: function (newE, oldE) {
          if (newE === null) {
            this.cargarEncuestas()
          }
        }
      },
      methods: {
        cargarEncuestas () {
          this.filas = []
          api.getEncuestasMatriculado()
            .then(r => {
              if (r.length > 0) {
                r.sort((a, b) => a.idEncuestas - b.idEncuestas)
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
              } else {
                this.subtitulo = 'Actualmente no estás matriculado a ninguna encuesta'
              }
            })
        },
        verEncuesta (id) {
          this.encuesta = id
        }
      }
    }
</script>
