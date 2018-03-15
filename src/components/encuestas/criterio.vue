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
        <div class="btn-group-toggle" data-toggle="buttons">
          <label class="btn btn-outline-success">
            <input type="checkbox" autocomplete="off" :checked="votar"> Votar
          </label>
        </div>
      </div>
    </div>
    <div class="form-row align-items-center">
      <div class="col-10">
        <small class="form-text text-muted">Propuesto por: {{criterio.propuestoPor}}</small>
      </div>
      <div class="col-2">
        {{votado}}
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
      votado: null
    }
  },
  methods: {
    votar (e) {
      console.log('votar', e)
      this.votado = e.target
    }
  }
}
</script>

<style scoped>

</style>
