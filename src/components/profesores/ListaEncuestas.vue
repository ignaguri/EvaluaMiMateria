<template>
    <div class="col-md-auto">
        <tabla :title="titulo" :subTitle="subtitulo" :columns="columnas" :data="filas"></tabla>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
import tabla from '../utils/Tabla.vue'
import encuesta from './Encuesta.vue'

    export default {
      props: [
        'id'
      ],
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
          columnas: ['IdEncuestas', 'Creador', 'Curso', 'Materia', 'EtapaActual', 'Nombre', 'FechaCreacion', 'FechaFinEtapaActual', 'CantMaxCriterios', 'CantMaxVotosPorPersona'],
          filas: []
        }
      },
      methods: {
        cargarEncuestas () {
          var aux = []
          api.getEncuestas()
            .then(r => {
              if (r.length > 0) {
                r.records.forEach(function (m) {
                  aux.push(m)
                })
              } else {
                this.subtitulo = 'No se encontraron encuestas creadas'
              }
            })
          this.filas = aux
        },
        verEncuesta (id) {
          console.log('ver Encuesta', id)
        }
      }
    }
</script>
