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
        <div class="btn-group btn-group-toggle" data-toggle="buttons">
          <label class="btn btn-light" @click.prevent="votar(1)" ref="lbl1">
            <input type="radio" v-model="voto" value="1" autocomplete="off">
            <img :src="imgs.enojado" :style="imgs.style" />
          </label>
          <label class="btn btn-light" @click.prevent="votar(2)" ref="lbl2">
            <input type="radio" v-model="voto" value="2" autocomplete="off">
            <img :src="imgs.triste" :style="imgs.style" />
          </label>
          <label class="btn btn-light" @click.prevent="votar(3)" ref="lbl3">
            <input type="radio" v-model="voto" value="3" autocomplete="off">
            <img :src="imgs.medio" :style="imgs.style" />
          </label>
          <label class="btn btn-light" @click.prevent="votar(4)" ref="lbl4">
            <input type="radio" v-model="voto" value="4" autocomplete="off">
            <img :src="imgs.feliz" :style="imgs.style" />
          </label>
          <label class="btn btn-light" @click.prevent="votar(5)" ref="lbl5">
            <input type="radio" v-model="voto" value="5" autocomplete="off">
            <img :src="imgs.muyFeliz" :style="imgs.style" />
          </label>
        </div>
        <hr>
      </div>
    </div>
  </form>
</template>

<script>
/* eslint-disable indent */
// TODO: achicar los archivos de imgs a 50x50 para mejor performance
import api from '../../api'
import muyFeliz from '../../assets/muy feliz.png'
import feliz from '../../assets/feliz.png'
import medio from '../../assets/medio.png'
import triste from '../../assets/triste.png'
import enojado from '../../assets/enojado.png'
  export default {
  props: {
    criterio: Object
  },
  data () {
    return {
      voto: null,
      imgs: {
        muyFeliz: muyFeliz,
        feliz: feliz,
        medio: medio,
        triste: triste,
        enojado: enojado,
        style: {
          width: '50px',
          height: '50px'
        }
      }
    }
  },
  mounted () {
    this.checkVotado()
  },
  methods: {
    votar (num) {
      this.voto = num
      this.$emit('voto', {idCriterio: this.criterio.idCriteriosXEncuesta, voto: this.voto})
    },
    checkVotado () {
      if (this.criterio.votos) {
        const userId = Number(api.checkLogin())
        let votos = this.criterio.votos.filter(v => v.idUsuario === userId)
        const respuesta = votos.length > 0 ? votos[0].respuesta : null
        if (respuesta) {
          this.$refs['lbl' + respuesta].className += ' focus active'
        }
      }
    }
  }
}
</script>

<style scoped>

</style>
