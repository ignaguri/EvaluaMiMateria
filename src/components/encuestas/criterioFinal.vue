<template>
  <form>
    <div class="form-row align-items-center">
      <div class="col-12">
        <div class="alert alert-primary" role="alert">
          {{criterio.criterio}}
        </div>
        <!--<input type="text" class="form-control" disabled :value="criterio.criterio" title="Criterio"/>-->
      </div>
    </div>
    <div class="form-row align-items-center">
      <div class="col-12">
        <div class="btn-group" role="group">
          <button type="button" class="btn btn-outline-light">
            <img src="../../assets/enojado.png" />
          </button>
          <button type="button" class="btn btn-outline-light">
            <img src="../../assets/triste.png" />
          </button>
          <button type="button" class="btn btn-outline-light">
            <img src="../../assets/medio.png" />
          </button>
          <button type="button" class="btn btn-outline-light">
            <img src="../../assets/feliz.png" />
          </button>
          <button type="button" class="btn btn-outline-light">
            <img src="../../assets/muy feliz.png" />
          </button>
        </div>
        <hr>
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
      votado: false
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
    }
  }
}
</script>

<style scoped>

</style>
