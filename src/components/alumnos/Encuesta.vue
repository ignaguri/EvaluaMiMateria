<template>
    <div>
        <a class="btn btn-sm btn-outline-dark" role="button" href="#" @click.prevent="volver">Volver</a>
    <div class="card border-dark mb-3" style="width: auto">
        <div class="card-header">Encuesta de: <strong>{{creador}}</strong></div>
        <div class="card-body text-dark">
            <h5 class="card-title"><u>"{{nombre}}"</u></h5>
            <p class="card-text">Materia: <strong>{{materia}}</strong></p>
            <p class="card-text">Curso: <strong>{{curso}}</strong></p>
            <p class="card-text">Etapa actual: <strong>{{etapa}}</strong></p>
            <p class="card-text" v-if="finEtapa">Fecha de fin de la etapa: <strong>{{finEtapa}}</strong></p>
            <p class="card-text">Cantidad máx. de criterios: <strong>{{cantMaxCriterios}}</strong></p>
            <p class="card-text">Cantidad máx. de votos por persona: <strong>{{cantMaxVotosPorPersona}}</strong></p>
            <p class="card-text">Fecha de creación: <strong>{{creacion}}</strong></p>
            <p class="card-text">Código: <strong>{{codigo}}</strong></p>
        </div>
    </div>
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
