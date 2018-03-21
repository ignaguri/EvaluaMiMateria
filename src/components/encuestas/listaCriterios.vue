<template>
    <div>
        <criterio-view v-for="c in criterios" :criterio="c" :canVotar="canVotar" :key="c.idCriterioXEncuesta" @voto="capturarVoto" @borrar="capturarBorrar"></criterio-view>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
import criterioView from './criterio'
    export default {
      props: [
        'encuesta',
        'canVotar'
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
              this.$emit('criterios', this.criterios.length)
            })
        },
        capturarVoto (e) {
          if (e.votado) {
            this.votados.push(e.id)
            this.$emit('voto', this.votados)
          } else {
            this.votados = this.votados.filter(c => c !== e.id)
            this.$emit('voto', this.votados)
          }
        },
        capturarBorrar (e) {
          if (confirm('¿Está seguro de que desea borrar este criterio?')) {
            api.borrarCriterio(e)
              .then(r => {
                if (r) {
                  this.cargarCriterios()
                }
              })
          }
        }
      }
    }
</script>
