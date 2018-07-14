<template>
  <div>
    <div class="row">
      <div class="col">
        <div class="text-center">
          <h4>Priorización de criterios</h4>
          <p>Elegir un orden de prioridad de los criterios del <strong>1</strong> (prioridad baja) al <strong>3</strong> (prioridad alta)</p>
        </div>
        <div class="form-group row">
          <div class="col-2"></div>
          <div class="col-6">
            <div class="progress" style="height: 31px;">
              <div class="progress-bar bg-info" id="cantVotos" role="progressbar" :style="barraVotosWidth" style="font-size: 1rem">
                {{cantVotos}}/{{cantMaxVotos}} Votos
              </div>
            </div>
          </div>
          <div class="col-2">
            <button type="button" class="btn btn-sm btn-block btn-success" @click="guardar">Guardar</button>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-12">
        <div class="text-center">
          <lista-criterios :encuesta="idEncuesta"
                           :canVotar="canVotar" :canBorrar="false"
                           @priorizar="capturarPriorizar" isPriorizacion>
          </lista-criterios>
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
      capturarPriorizar (e) {
        this.criteriosVotados = e
        this.cantVotos = e.length
        let porcentaje = (this.cantVotos / this.cantMaxVotos) * 100
        this.barraVotosWidth = 'width:' + porcentaje + '%'
        this.canVotar = this.cantVotos < this.cantMaxVotos
      },
      guardar () {
        api.guardarPriorizacion(this.criteriosVotados, this.encuesta.etapaActual, this.idEncuesta)
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
