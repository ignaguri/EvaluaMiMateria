<template>
  <form>
    <div class="form-row align-items-center">
      <div class="col-11">
        <input type="text" class="form-control" disabled :value="criterio.criterio" title="Criterio"/>
      </div>
      <div class="col-1">
        <button type="button" :class="`btn btn-${styleBoton}`" @click="votar" ref="btnPriorizar">{{textoBoton}}</button>

      </div>
    </div>
    <div class="form-row align-items-center">
      <div class="col-1">
      </div>
      <div class="col-10">
        <small class="form-text text-muted">Total puntos priorización: {{votos}} - Propuesto por: {{criterio.propuestoPor}}</small>
      </div>
      <div class="col-1">
      </div>
    </div>
  </form>
</template>

<script>
/* eslint-disable indent */
import api from '../../api'
  export default {
  props: {
    criterio: Object,
    canVotar: Boolean
  },
  data () {
    return {
      votado: false,
      votos: 0,
      textoBoton: 'Priorizar',
      styleBoton: 'secondary'
    }
  },
  watch: {
    canVotar: function () {
      this.checkVotability()
    }
  },
    mounted () {
      this.getVotos()
    },
  methods: {
    votar () {
      switch (this.votado) {
        case false:
          this.votado = 1
          this.decorateBoton(1)
          break
        case 1:
          this.votado = 2
          this.decorateBoton(2)
          break
        case 2:
          this.votado = 3
          this.decorateBoton(3)
          break
        case 3:
          this.votado = false
          this.decorateBoton(false)
          break
      }
      this.$emit('priorizar', {id: this.criterio.idCriteriosXEncuesta, priorizado: this.votado})
    },
    checkVotability () {
      // TODO: no permitir que haya votos con mismo número
      if (this.canVotar) {
        this.$refs.btnPriorizar.disabled = false
      } else {
        if (!this.votado) {
          this.$refs.btnPriorizar.disabled = true
        }
      }
    },
    getVotos () {
      api.getVotosCriterio(this.criterio.idCriteriosXEncuesta, this.criterio.idEncuesta)
        .then(r => {
          if (r.votosxcriterio) {
            this.votos = r.votosxcriterio.reduce((acc, cur) => acc + cur.priorizacion, 0)
            const user = Number(api.checkLogin())
            r.votosxcriterio.forEach(v => {
              if (v.idUsuarioVotante === user) {
                this.votado = v.priorizacion
                this.decorateBoton(v.priorizacion)
                this.$emit('priorizar', {id: this.criterio.idCriteriosXEncuesta, priorizado: this.votado})
              }
            })
          }
        })
    },
    decorateBoton (priorizacion) {
      switch (priorizacion) {
        case 1:
          this.textoBoton = 1
          this.styleBoton = 'warning'
          break
        case 2:
          this.textoBoton = 2
          this.styleBoton = 'primary'
          break
        case 3:
          this.textoBoton = 3
          this.styleBoton = 'success'
          break
        default:
          this.textoBoton = 'Priorizar'
          this.styleBoton = 'secondary'
          break
      }
    }
  }
}
</script>

<style scoped>

</style>
