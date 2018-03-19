<template>
    <div>
        <criterio-view v-for="c in criterios" :criterio="c" :key="c.idCriterioXEncuesta" @voto="capturarVoto"></criterio-view>
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
          criterios: [],
          votados: []
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
        },
        capturarVoto (e) {
          if (e.votado) {
            this.votados.push(e.id)
          } else {
            this.votados = this.votados.filter(c => c !== e.id)
          }
        }
      }
    }
</script>
