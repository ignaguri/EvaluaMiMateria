<template>
    <div>
        <button type="button" class="btn btn-outline-info" @click="vista = 'resultados'">Ver resultados</button>
        <button type="button" class="btn btn-outline-success" @click="vista = 'votacion'">Votar</button>
        <div v-if="vista === 'votacion'">
            <h4>Semana n° {{semana}}</h4>
            <div v-for="c in criterios" :key="c.idCriteriosXEncuesta">
                <criterio-view :criterio="c" @voto="capturarVoto"></criterio-view>
            </div>
        </div>
        <div v-if="vista === 'resultados'">
            <h4>Semana n° {{semana}}</h4>
            <dl class="row">
                <div v-for="c in criterios" :key="c.idCriteriosXEncuesta">
                <dt class="col-sm-3">{{c.idCriteriosXEncuesta}}</dt>
                <dd class="col-sm-9">
                    <p>{{c.criterio}}</p>
                    <p>Votos: {{c.votos.length}}</p>
                </dd>
                </div>
            </dl>
        </div>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
import criterioView from './criterioFinal'
    export default {
      props: [
        'idEncuesta'
      ],
      components: {
        criterioView
      },
      computed: {
        semana: function () {
          return api.getWeekNumber(new Date())
        }
      },
      data () {
        return {
          criterios: null,
          vista: null
        }
      },
      mounted () {
        this.cargarEncuesta()
      },
      methods: {
        cargarEncuesta () {
          api.getCriteriosDefinitivosConVotosXSemana(this.idEncuesta)
            .then(r => {
              this.criterios = r
            })
        },
        volver () {
          this.$parent.encuesta = null
        },
        capturarVoto (voto) {
          api.guardarEncuesta(voto.idCriterio, voto.voto)
            .then(r => {
              if (r) {
                alert('Votado con éxito')
              } else {
                alert('Error al guardar el voto')
              }
            })
        }
      }
    }
</script>
