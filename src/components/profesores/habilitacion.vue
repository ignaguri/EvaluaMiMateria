<template>
  <div class="row">
    <div class="col">
      <div class="text-center">
        <br>
        <button type="button" class="btn btn-sm btn-success" @click="guardar">Guardar</button>
      </div>
      <criterio-view v-for="c in criterios" :criterio="c" :key="c.idCriterioXEncuesta"
                     @voto="capturarVoto"></criterio-view>
    </div>
  </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
import criterioView from './criterio'
    export default {
      props: [
        'encuesta',
        'fecha'
      ],
      components: {
        criterioView
      },
      data () {
        return {
          criterios: [],
          votados: [],
          canVotar: false,
          votado: false,
          textoBoton: 'Definitivo'
        }
      },
      mounted () {
        this.cargarCriterios()
      },
      methods: {
        cargarCriterios () {
          api.getCriteriosXEncuestaConVotos(this.encuesta)
            .then(r => {
              r.sort((a, b) => {
                return a.votos.length < b.votos.length
              })
              this.criterios = r
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
        guardar () {
          api.guardarCriteriosDefinitivos(this.votados)
            .then(r => {
              if (r) {
                this.guardarCambioEtapa()
              } else {
                alert('Error al guardar')
              }
            })
        },
        guardarCambioEtapa () {
          api.cambiarEtapa(this.encuesta, 'Habilitada', this.fecha)
            .then(r => {
              if (r) {
                alert('Etapa cambiada correctamente')
                this.$parent.volver()
              } else {
                alert('Error al cambiar la etapa')
              }
            })
        }
      }
    }
</script>
