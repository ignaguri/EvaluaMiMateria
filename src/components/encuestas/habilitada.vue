<template>
    <div>
        <div class="buttons">
            <button type="button" class="btn btn-outline-info" @click="vista = 'resultados'">Ver resultados</button>
            <button type="button" class="btn btn-outline-success" @click="vista = 'votacion'">Votar</button>
            <hr>
        </div>
        <div v-if="vista === 'votacion'">
            <h4>Semana n° {{semana}}</h4>
            <div v-for="c in criterios" :key="c.idCriteriosXEncuesta">
                <criterio-view :criterio="c" @voto="capturarVoto"></criterio-view>
            </div>
        </div>
        <div v-if="vista === 'resultados'">
            <h4>Históricos</h4>
            <column-chart
                    :data="chartData"
                    :discrete="true"
                    ytitle="Cantidad de votos"
                    xtitle="Puntaje"
                    :messages="{empty: 'No se encontraron datos'}"
                    :download="true"
            >
            </column-chart>
        </div>
    </div>
</template>
<script>
// TODO: agregar ver graficos de votos propios y sólo de esta semana
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
          vista: null,
          chartData: [] // [{name: 'Workout', data: {'2017-01-01 00:00:00 -0800': 3, '2017-01-02 00:00:00 -0800': 4}}, {name: 'Call parents', data: {'2017-01-01 00:00:00 -0800': 5, '2017-01-02 00:00:00 -0800': 3}}]
        }
      },
      watch: {
        vista: function () {
          if (this.vista === 'resultados') this.cargarResultados()
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
        cargarResultados () {
          api.getCriteriosDefinitivosConVotos(this.idEncuesta)
            .then(r => {
              this.chartData = []
              r.forEach(c => {
                this.chartData.push({
                  name: c.criterio,
                  data: c.votos
                })
              })
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
                this.cargarEncuesta()
              } else {
                alert('Error al guardar el voto')
              }
            })
        }
      }
    }
</script>
