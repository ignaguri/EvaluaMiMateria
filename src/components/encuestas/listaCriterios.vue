<template>
    <div>
        <criterio-view v-for="c in criterios" :criterio="c" :key="c.idCriterioXEncuesta"></criterio-view>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
import criterioView from './criterio'
    export default {
      props: [
        'encuesta'
      ],
      components: {
        criterioView
      },
      data () {
        return {
          criterios: []
        }
      },
      mounted () {
        this.cargarCriterios()
      },
      methods: {
        cargarCriterios () {
          api.getCriteriosXEncuesta(this.encuesta)
            .then(r => {
              this.criterios = r
            })
        }
      }
    }
</script>
