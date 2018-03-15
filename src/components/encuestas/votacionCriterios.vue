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
      </div>
    </div>
    <div class="row">
      <div class="col-12">
        <div class="text-center">
          <lista-criterios ref="lista" :encuesta="encuesta"></lista-criterios>
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
      'encuesta'
    ],
    components: {
      listaCriterios
    },
    data () {
      return {
        criterio: null
      }
    },
    mounted () {
    },
    methods: {
      agregar () {
        console.log('implementar', this.criterio)
        api.postCriteriosXEncuesta(this.criterio, this.encuesta)
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
