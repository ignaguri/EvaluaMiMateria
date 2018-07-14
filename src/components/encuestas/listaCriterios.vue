<template>
    <div v-if="!isPriorizacion">
        <criterio-votacion v-for="c in criterios" :criterio="c"
                           :canVotar="canVotar" :key="c.idCriterioXEncuesta"
                           @voto="capturarVoto" :canBorrar="canBorrar"
                           @borrar="capturarBorrar"></criterio-votacion>
    </div>
    <div v-else>
        <criterio-priorizacion v-for="c in criterios" :criterio="c"
                               :canVotar="canVotar" :key="c.idCriterioXEncuesta"
                               @priorizar="capturarPriorizacion">
        </criterio-priorizacion>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
import criterioVotacion from './criterioVotacion'
import criterioPriorizacion from './criterioPriorizacion'
    export default {
      props: {
        encuesta: [String, Number],
        canVotar: Boolean,
        canBorrar: {
          default: true
        },
        isPriorizacion: {
          type: Boolean,
          default: false
        }
      },
      components: {
        criterioVotacion,
        criterioPriorizacion
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
        },
        capturarPriorizacion (e) {
          if (e.priorizado) {
            const existente = this.votados.findIndex(v => v.id === e.id)
            if (existente >= 0) {
              this.votados[existente].priorizado = e.priorizado
            } else {
              this.votados.push(e)
            }
            this.$emit('priorizar', this.votados)
          } else {
            this.votados = this.votados.filter(c => c.id !== e.id)
            this.$emit('priorizar', this.votados)
          }
        }
      }
    }
</script>
