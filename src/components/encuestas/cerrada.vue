<template>
    <div>
      <p>CERRADA</p>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
    export default {
      props: [
        'id'
      ],
      data () {
        return {
          encuesta: null,
          nombre: null,
          curso: null,
          materia: null,
          creador: null,
          etapa: null,
          creacion: null,
          finEtapa: null,
          cantMaxCriterios: null,
          cantMaxVotosPorPersona: null,
          codigo: null
        }
      },
      mounted () {
        this.cargarEncuesta()
      },
      methods: {
        cargarEncuesta () {
          api.getEncuestaFull(this.id)
            .then(r => {
              this.encuesta = r
              this.nombre = r.nombre
              this.curso = r.curso
              this.materia = r.materia
              this.creador = r.creador
              this.etapa = r.etapaActual
              this.creacion = r.fechaCreacion
              this.finEtapa = r.fechaFinEtapaActual
              this.cantMaxCriterios = r.cantMaxCriterios
              this.cantMaxVotosPorPersona = r.cantMaxVotosPorPersona
              this.codigo = r.codigo === null ? 'No generado' : r.codigo
            })
        },
        volver () {
          this.$parent.encuesta = null
        }
      }
    }
</script>
