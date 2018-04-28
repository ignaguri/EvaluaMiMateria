<template>
    <div>
      <p>Encuesta para la semana #{{semana}}</p>
      <div v-for="c in criterios" :key="c.idCriteriosXEncuesta">
        <criterio-view :criterio="c" @voto="capturarVoto"></criterio-view>
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
      computed: {
        semana: function () {
          return api.getWeekNumber(new Date())
        }
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
          api.getCriteriosDefinitivosConVotosXSemana(this.idEncuesta)
            .then(r => {
              this.criterios = r
            })
        },
        volver () {
          this.$parent.encuesta = null
        },
        capturarVoto (voto) {
          api.guardarEncuesta(voto.idCriterio, voto.voto)
            .then(r => {
              if (r) {
                alert('Votado con éxito')
              } else {
                alert('Error al guardar el voto')
              }
            })
        }
      }
    }
</script>
