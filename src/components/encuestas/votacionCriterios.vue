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
          <div class="col-6">
            <div class="progress">
              <div class="progress-bar bg-info" id="cantCriterios" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                2/12 Criterios
              </div>
            </div>
          </div>
          <!--<label for="cantVotos" class="col-3 col-form-label">Cant max votos</label>-->
          <div class="col-6">
            <div class="progress">
              <div class="progress-bar bg-success" id="cantVotos" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                2/12 Votos
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-12">
        <div class="text-center">
          <lista-criterios ref="lista" :encuesta="idEncuesta"></lista-criterios>
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
        cantMaxCriterios: this.encuesta.cantMaxCriterios,
        cantMaxVotos: this.encuesta.cantMaxVotosPorPersona
      }
    },
    mounted () {
      console.log('max criterios', this.cantMaxCriterios, 'cant votos', this.cantMaxVotos)
    },
    methods: {
      agregar () {
        console.log('implementar', this.criterio)
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
      }
    }
  }
</script>
