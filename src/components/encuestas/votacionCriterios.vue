<template>
  <div>
    <div class="row">
      <div class="col">
        <div class="form-group row">
          <label for="txt_criterio" class="col-3 col-form-label">Proponer un criterio:</label>
          <div class="col-7">
            <input class="form-control" type="text" id="txt_criterio" v-model="criterio"
                   placeholder="Criterio a proponer" @keyup.enter="agregar">
          </div>
          <div class="col-2">
            <button type="button" class="btn btn-outline-success" @click="agregar">Agregar</button>
          </div>
        </div>
        <div class="form-group row">
          <!--<label for="cantCriterios" class="col-3 col-form-label">Criterios propuestos</label>-->
          <div class="col-5">
            <div class="progress" style="height: 31px;">
              <div class="progress-bar bg-warning" id="cantCriterios" role="progressbar" :style="barraCriteriosWidth" style="font-size: 1rem">
                {{cantCriterios}}/{{cantMaxCriterios}} Criterios
              </div>
            </div>
          </div>
          <div class="col-2">
            <button type="button" class="btn btn-sm btn-success" @click="guardar">Guardar</button>
          </div>
          <!--<label for="cantVotos" class="col-3 col-form-label">Cant max votos</label>-->
          <div class="col-5">
            <div class="progress" style="height: 31px;">
              <div class="progress-bar bg-info" id="cantVotos" role="progressbar" :style="barraVotosWidth" style="font-size: 1rem">
                {{cantVotos}}/{{cantMaxVotos}} Votos
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-12">
        <div class="text-center">
          <lista-criterios ref="lista" :encuesta="idEncuesta" :canVotar="canVotar" @criterios="capturarCriterios" @voto="capturarVoto"></lista-criterios>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
/* eslint-disable indent */
  import api from '../../api'
import listaCriterios from './listaCriterios'
  export default {
    props: [
      'idEncuesta',
      'encuesta'
    ],
    components: {
      listaCriterios
    },
    data () {
      return {
        criterio: null,
        cantCriterios: null,
        cantMaxCriterios: this.encuesta.cantMaxCriterios,
        cantVotos: null,
        cantMaxVotos: this.encuesta.cantMaxVotosPorPersona,
        barraCriteriosWidth: 'width: 0%',
        barraVotosWidth: 'width: 0%',
        canVotar: true,
        criteriosVotados: []
      }
    },
    mounted () {
    },
    methods: {
      agregar () {
        if (this.cantCriterios === this.cantMaxCriterios) {
          alert('Cantidad máxima de criterios alcanzada')
          return
        }
        api.postCriteriosXEncuesta(this.criterio, this.idEncuesta)
          .then(r => {
            if (r) {
              alert('Exito')
              this.criterio = null
              this.$refs.lista.cargarCriterios()
            } else {
              alert('Error')
            }
          })
      },
      capturarVoto (e) {
        this.criteriosVotados = e
        this.cantVotos = e.length
        let porcentaje = (this.cantVotos / this.cantMaxVotos) * 100
        this.barraVotosWidth = 'width:' + porcentaje + '%'
        if (this.cantVotos >= this.cantMaxVotos) {
          this.canVotar = false
        } else {
          this.canVotar = true
        }
      },
      capturarCriterios (e) {
        this.cantCriterios = e
        let porcentaje = (this.cantCriterios / this.cantMaxCriterios) * 100
        this.barraCriteriosWidth = 'width:' + porcentaje + '%'
      },
      guardar () {
        api.guardarVotacion(this.criteriosVotados, this.encuesta.etapaActual)
          .then(r => {
            if (r) {
              alert('Guardado con éxito!')
              this.$emit('volver')
            } else {
              alert('Error al guardar. Intente nuevamente')
            }
          })
      }
    }
  }
</script>
