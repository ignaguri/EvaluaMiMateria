<template>
    <div>
        <a class="btn btn-sm btn-outline-dark" role="button" href="#" @click.prevent="volver">Volver</a>
      <hr>
    <!--<div class="card border-dark mb-3" style="width: auto">-->
        <!--<div class="card-header">Encuesta de: <strong>{{creador}}</strong></div>-->
        <!--<div class="card-body text-dark">-->
            <!--<h5 class="card-title"><u>"{{nombre}}"</u></h5>-->
            <!--<p class="card-text">Materia: <strong>{{materia}}</strong></p>-->
            <!--<p class="card-text">Curso: <strong>{{curso}}</strong></p>-->
            <!--<p class="card-text">Etapa actual: <strong>{{etapa}}</strong></p>-->
            <!--<p class="card-text" v-if="finEtapa">Fecha de fin de la etapa: <strong>{{finEtapa}}</strong></p>-->
            <!--<p class="card-text">Cantidad máx. de criterios: <strong>{{cantMaxCriterios}}</strong></p>-->
            <!--<p class="card-text">Cantidad máx. de votos por persona: <strong>{{cantMaxVotosPorPersona}}</strong></p>-->
            <!--<p class="card-text">Fecha de creación: <strong>{{creacion}}</strong></p>-->
            <!--<p class="card-text">Código: <strong>{{codigo}}</strong></p>-->
        <!--</div>-->
    <!--</div>-->
        <div class="container-fluid">
          <component :is="current" :encuesta="id"></component>
        </div>
        <!--<div class="col">-->
          <!--<component v-if="etapa == 'Votacion Criterios'" v-bind:is="votacion"></component>-->
          <!--<span class="alert-heading" v-if="etapa == 'Priorizacion'"><priorizacion></priorizacion></span>-->
          <!--<span class="alert-heading" v-if="etapa == 'Habilitada'"><habilitada></habilitada></span>-->
          <!--<span class="alert-heading" v-if="etapa == 'Cerrada'"><cerrada></cerrada></span>-->
        <!--</div>-->
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
import votacion from '../encuestas/votacionCriterios'
import priorizacion from '../encuestas/priorizacion'
import habilitada from '../encuestas/habilitada'
import cerrada from '../encuestas/cerrada'
    export default {
      props: [
        'id'
      ],
      components: {
        votacion,
        priorizacion,
        habilitada,
        cerrada
      },
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
          codigo: null,
          current: null
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
              switch (this.etapa) {
                case 'Votacion Criterios':
                  this.current = 'votacion'
                      break
                case 'Priorizacion':
                  this.current = 'priorizacion'
                      break
                case 'Habilitada':
                  this.current = 'habilitada'
                      break
                case 'Cerrada':
                  this.current = 'cerrada'
                      break
              }
            })
        },
        volver () {
          this.$parent.encuesta = null
        }
      }
    }
</script>
