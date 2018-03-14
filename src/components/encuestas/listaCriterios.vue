<template>
    <div>
      <!--<div v-for="c in criterios" :key="c.idCriteriosXEncuesta">-->
        <!--<div class="alert-info">{{c.criterio}}</div>-->
      <!--</div>-->
      <ul>
        <template v-for="c in criterios">
          <li :key="c.idCriteriosXEncuesta">{{ c.criterio }}</li>
        </template>
      </ul>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
    export default {
      props: [
        'encuesta'
      ],
      data () {
        return {
          criterios: []
        }
      },
      mounted () {
        this.cargarCriterios()
      },
      methods: {
        cargarCriterios () {
          api.getCriteriosXEncuesta(this.encuesta)
            .then(r => {
              this.criterios = r
            })
        }
      }
    }
</script>
