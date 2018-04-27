<template>
  <form>
    <div class="form-row align-items-center">
      <div class="col-1">
        <span class="badge badge-info">Votos {{votos}}</span>
      </div>
      <div class="col-10">
        <input type="text" class="form-control" disabled :value="criterio.criterio" title="Criterio"/>
      </div>
      <div class="col-1">
        <a href="#" @click.prevent="checkVotar" class="badge badge-success">{{textoBoton}}</a>
        <input
          type="checkbox"
          :id="criterio.idCriteriosXEncuesta"
          v-model="votado"
          autocomplete="off"
          ref="chkVotar"
        >
      </div>
    </div>
    <div class="form-row align-items-center">
      <div class="col-1">
      </div>
      <div class="col-10">
        <small class="form-text text-muted">Propuesto por: {{criterio.propuestoPor}}</small>
      </div>
      <div class="col-1">
      </div>
    </div>
  </form>
</template>

<script>
/* eslint-disable indent */
  export default {
  props: {
    criterio: Object
  },
  data () {
    return {
      votado: false,
      votos: this.criterio.votos.length,
      textoBoton: 'Definitivo'
    }
  },
  watch: {
    votado: function () {
      this.votar()
    }
  },
  methods: {
    votar () {
      this.$emit('voto', {id: this.criterio.idCriteriosXEncuesta, votado: this.votado})
    },
    checkVotar () {
        this.$refs.chkVotar.checked = !this.$refs.chkVotar.checked
        this.votado = !this.votado
    }
  }
}
</script>

<style scoped>

</style>
