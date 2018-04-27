<template>
    <div>
      <p>HABILITADA</p>
      <div v-for="c in criterios" :key="c.idCriteriosXEncuesta">
        <criterio-view :criterio="c"></criterio-view>
      </div>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
import criterioView from './criterioFinal'
    export default {
      props: [
        'idEncuesta'
      ],
      components: {
        criterioView
      },
      data () {
        return {
          criterios: null
        }
      },
      mounted () {
        this.cargarEncuesta()
      },
      methods: {
        cargarEncuesta () {
          api.getCriteriosXEncuesta(this.idEncuesta)
            .then(r => {
              this.criterios = r.filter(c => c.esDefinitivo)
            })
        },
        volver () {
          this.$parent.encuesta = null
        }
      }
    }
</script>
