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
            <a class="btn btn-outline-info" role="button" href="#" @click.prevent="cambiarEtapa" data-toggle="modal" data-target="#myModal">Cambiar de etapa</a>
            <a class="btn btn-outline-info" role="button" href="#" @click.prevent="estadisticas">Ver votaciones</a>
        </div>
    </div>
        <div class="modal" tabindex="-1" role="dialog" id="myModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">{{modal.title}}</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" v-html="modal.body">
                    </div>
                    <div class="modal-footer">
                        <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
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
          modal: {
            title: null,
            body: null
          }
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
            })
        },
        volver () {
          this.$parent.encuesta = null
        },
        cambiarEtapa () {
          console.log('implementar')
          this.modal.title = 'Cambiar de etapa'
          let content = '<div class="row">' +
            '<div class="col-md-12">' +
            '<p>Etapa actual: ' + this.etapa +
            '</p>' +
            '</div>' +
            '</div>'
          this.modal.body = content
        },
        estadisticas () {
          console.log('implementar')
        }
      }
    }
</script>
