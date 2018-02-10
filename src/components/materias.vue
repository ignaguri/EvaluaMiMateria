<template>
    <div class="row">
        <div class="col-md-4 col-md-offset-5">
            <button type="button" class="btn btn-success" @click="cargar">Ver materias</button>
            <ul>
                <li v-for="m in materias" v-bind:key="m">{{m}}</li>
            </ul>
        </div>
        <div class="text-center">
            <label for="materia">Agregar materia:</label>
            <input type="text" id="materia" v-model="materia">
            <button type="button" class="btn btn-success" @click="insert">Add materia</button>
        </div>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../api'
    export default {
      data () {
        return {
          materia: '',
          materias: []
        }
      },
      methods: {
        cargar: function () {
          var aux = []
          api.getMaterias()
            .then(response => {
              if (!response) return
              response.records.forEach(function (m) {
                aux.push(m[1])
              })
            })
            .catch(error => {
              alert('Error' + error)
            })
          this.materias = aux
        },
        insert: function () {
          var obj = {nombre: this.materia}
          api.postMaterias(obj)
            .then(r => {
              if (r) {
                alert('Se insertó correctamente')
                this.cargar()
              } else {
                alert('No se pudo guardar la materia')
              }
            })
        }
      }
    }
</script>
