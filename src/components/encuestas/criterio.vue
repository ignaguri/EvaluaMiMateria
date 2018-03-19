<template>
  <!--<div class="row">-->
  <!--<input type="text" class="form-control" disabled :value="criterio.criterio" title="Criterio"/>-->
  <!--<div class="btn-group-toggle" data-toggle="buttons">-->
  <!--<label class="btn btn-outline-success">-->
  <!--<input type="checkbox" autocomplete="off"> Votar-->
  <!--</label>-->
  <!--</div>-->
  <!--<small class="form-text text-muted">Propuesto por: {{criterio.propuestoPor}}</small>-->
  <!--</div>-->
  <form>
    <div class="form-row align-items-center">
      <div class="col-10">
        <input type="text" class="form-control" disabled :value="criterio.criterio" title="Criterio"/>
      </div>
      <div class="col-2">
          <label :for="criterio.idCriterioXEncuesta">Votar
            <!--<input type="checkbox" autocomplete="off" id="checkbox" name="checkbox" :value="value" v-model="votados">-->
            <input
              type="checkbox"
              :id="criterio.idCriterioXEncuesta"
              v-model="votado"
              autocomplete="off"
            >
          </label>
<!--        <div data-toggle="buttons">
          <label class="btn btn-success" @click="votar">
            <input type="checkbox" value="value" autocomplete="off" v-model="votado"> Votar
          </label>
        </div>-->
      </div>
    </div>
    <div class="form-row align-items-center">
      <div class="col-10">
        <small class="form-text text-muted">Propuesto por: {{criterio.propuestoPor}}</small>
      </div>
      <div class="col-2">
      </div>
    </div>
  </form>
</template>

<script>
export default {
  props: [
    'criterio'
  ],
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
