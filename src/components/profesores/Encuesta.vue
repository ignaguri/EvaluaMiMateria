<template>
  <div>
    <a class="btn btn-sm btn-outline-dark" role="button" href="#" @click.prevent="volver">Volver</a>
    <div v-if="!habilitacion">
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
          <a class="btn btn-outline-info" role="button" href="#" @click.prevent="cambiarEtapa" data-toggle="modal"
             data-target="#modalCambiarEtapa">Cambiar de etapa</a>
          <a class="btn btn-outline-primary" role="button" href="#" data-toggle="modal"
             data-target="#modalGenerarCodigo">Generar
            código</a>
          <a class="btn btn-outline-success" role="button" href="#" @click.prevent="estadisticas">Ver votaciones</a>
        </div>
      </div>
      <div class="modal" tabindex="-1" role="dialog" id="modalCambiarEtapa">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">{{modalEtapa.title}}</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="row">
                <div class="col-md-12">
                  <div class="alert alert-info">Etapa actual: <strong>{{etapa}}</strong></div>
                  <hr>
                  <p>Pasar a: <span class="alert-success">{{modalEtapa.proxEtapa}}</span></p>
                  <label for="fechaFin">Fecha de finalización de etapa</label>
                  <input type="date" id="fechaFin" v-model="modalEtapa.fechaFin" class="form-control"/>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
              <button type="button" class="btn btn-success" data-dismiss="modal" @click="guardarCambioEtapa">Aplicar
              </button>
            </div>
          </div>
        </div>
      </div>
      <div class="modal" tabindex="-1" role="dialog" id="modalGenerarCodigo">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">{{modalCodigo.title}}</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <div class="row">
                <div class="col-md-12">
                  <div class="form-group">
                    <label for="txt_codigo">Código identificador de la encuesta</label>
                    <input type="text" class="form-control" id="txt_codigo" placeholder="Código"
                           v-model="modalCodigo.codigo" required>
                    <span class="alert-secondary"><small>Este será el código utilizado por los alumnos para unirse a la encuesta</small></span>
                  </div>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
              <button type="button" class="btn btn-success" data-dismiss="modal" @click="generarCodigo">Generar</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div v-else>
      <habilitacion :encuesta="id" :fecha="modalEtapa.fechaFin"></habilitacion>
    </div>
  </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
import habilitacion from './habilitacion'

    export default {
      props: [
        'id'
      ],
      components: {
        habilitacion
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
          modalEtapa: {
            title: null,
            proxEtapa: null,
            fechaFin: null
          },
          modalCodigo: {
            title: 'Generar código de encuesta',
            codigo: null
          },
          habilitacion: false
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
        },
        cambiarEtapa () {
          // Creación -> Votación criterios -> Priorización -> Habilitada -> Cerrada
          this.modalEtapa.title = 'Cambiar de etapa'
          switch (this.etapa) {
            case 'Creada':
              this.modalEtapa.proxEtapa = 'Votación de criterios'
                  break
            case 'Votacion Criterios':
              this.modalEtapa.proxEtapa = 'Priorización'
              break
            case 'Priorizacion':
              this.modalEtapa.proxEtapa = 'Habilitada'
              break
            case 'Habilitada':
              this.modalEtapa.proxEtapa = 'Cerrada'
              break
          }
        },
        guardarCambioEtapa () {
          if (this.modalEtapa.fechaFin === null) {
            alert('Debe completar la fecha')
            return
          }
          if (this.modalEtapa.proxEtapa === 'Habilitada') {
            this.habilitacion = true
            return
          }
          api.cambiarEtapa(this.id, this.modalEtapa.proxEtapa, this.modalEtapa.fechaFin)
            .then(r => {
              if (r) {
                alert('Etapa cambiada correctamente')
                this.volver()
              } else {
                alert('Error al cambiar la etapa')
              }
            })
        },
        estadisticas () {
          console.log('implementar')
        },
        generarCodigo () {
          api.generarCodigo(this.id, this.modalCodigo.codigo)
            .then(r => {
              if (r) {
                this.codigo = r
              }
            })
        }
      }
    }
</script>
