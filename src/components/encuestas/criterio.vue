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
      <div class="col-1">
        <a v-if="canBorrar" href="#" @click.prevent="borrar" class="badge badge-danger">Borrar</a>
      </div>
      <div class="col-10">
        <input type="text" class="form-control" disabled :value="criterio.criterio" title="Criterio"/>
      </div>
      <div class="col-1">
          <!--<label :for="criterio.idCriterioXEncuesta">-->
            <a href="#" @click.prevent="checkVotar" ref="btnVotar" class="badge badge-success">{{textoBoton}}</a>
            <!--<input type="checkbox" autocomplete="off" id="checkbox" name="checkbox" :value="value" v-model="votados">-->
            <input
              type="checkbox"
              :id="criterio.idCriterioXEncuesta"
              v-model="votado"
              autocomplete="off"
              ref="chkVotar"
            >
          <!--</label>-->
<!--        <div data-toggle="buttons">
          <label class="btn btn-success" @click="votar">
            <input type="checkbox" value="value" autocomplete="off" v-model="votado"> Votar
          </label>
        </div>-->
      </div>
    </div>
    <div class="form-row align-items-center">
      <div class="col-1">
      </div>
      <div class="col-10">
        <small class="form-text text-muted">Total votos: {{votos}} - Propuesto por: {{criterio.propuestoPor}}</small>
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
    canVotar: Boolean,
    canBorrar: Boolean
  },
  data () {
    return {
      votado: false,
      votos: 0,
      textoBoton: 'Votar'
    }
  },
  watch: {
    votado: function () {
      this.votar()
    },
    canVotar: function () {
      this.checkVotability()
    }
  },
    mounted () {
      this.getVotos()
    },
  methods: {
    votar () {
      this.$emit('voto', {id: this.criterio.idCriteriosXEncuesta, votado: this.votado})
    },
    checkVotability () {
      if (this.canVotar) {
        this.$refs.chkVotar.disabled = false
      } else {
        if (!this.$refs.chkVotar.checked) {
          this.$refs.chkVotar.disabled = true
        }
      }
    },
    checkVotar () {
      if (this.canVotar) {
        this.$refs.chkVotar.checked = !this.$refs.chkVotar.checked
        this.votado = !this.votado
      } else {
        if (this.$refs.chkVotar.checked) {
          this.$refs.chkVotar.checked = !this.$refs.chkVotar.checked
          this.votado = !this.votado
        }
      }
    },
    borrar () {
      this.$emit('borrar', this.criterio.idCriteriosXEncuesta)
    },
    getVotos () {
      api.getVotosCriterio(this.criterio.idCriteriosXEncuesta, this.criterio.idEncuesta)
        .then(r => {
          if (r.votosxcriterio) {
            this.votos = r.length || 0
            const user = Number(api.checkLogin())
            r.votosxcriterio.forEach(v => {
              if (v.idUsuarioVotante === user) {
                this.votado = true
              }
            })
          }
          switch (r.etapaActual) {
            case 1:
            case 2:
              this.textoBoton = 'Votar'
              break
            case 3:
              this.textoBoton = 'Priorizar'
                  break
          }
        })
    }
  }
}
</script>

<style scoped>

</style>
