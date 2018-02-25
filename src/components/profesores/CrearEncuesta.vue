<template>
    <div>
        <div class="row">
            <div class="col col-md-2"></div>
            <div class="col-md-8">
                <h4>Crear una nueva encuesta</h4>
                <form @submit.prevent="enviar">
                    <div class="form-group">
                        <label for="cmb_curso">Curso</label>
                        <select class="form-control" id="cmb_curso" v-model="curso" required>
                            <option :value="null">Seleccione un curso</option>
                            <option v-for="c in cursos" :key="c.id">{{c.nombre}}({{c.turno}})</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="cmb_materia">Materia</label>
                        <select class="form-control" id="cmb_materia" v-model="materia" required>
                            <option :value="null">Seleccione una materia</option>
                            <option v-for="m in materias" :key="m.id">{{m.nombre}}</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="txt_nombre">Nombre de la encuesta</label>
                        <input type="text" class="form-control" id="txt_nombre" placeholder="Nombre" v-model="nombre" required>
                    </div>
                    <div class="form-group">
                        <label for="txt_cant_criterios">Cantidad máxima de criterios</label>
                        <input type="number" class="form-control" id="txt_cant_criterios" placeholder="Cant. máx de criterios" v-model="cantCriterios" required>
                    </div>
                    <div class="form-group">
                        <label for="txt_cant_votos">Cantidad máxima de votos por persona</label>
                        <input type="number" class="form-control" id="txt_cant_votos" placeholder="Cant. máx de votos p/persona" v-model="cantVotos" required>
                    </div>
                    <button type="submit" class="btn btn-success">Crear</button>
                </form>
            </div>
            <div class="col col-md-2"></div>
        </div>
    </div>
</template>
<script>
/* eslint-disable indent */
import api from '../../api'
    export default {
      data () {
        return {
          cursos: [],
          materias: [],
          curso: null,
          materia: null,
          nombre: null,
          cantCriterios: null,
          cantVotos: null
        }
      },
      mounted () {
        this.cargarCursos()
        this.cargarMaterias()
      },
      methods: {
        enviar () {
          console.log('enviar')
        },
        cargarMaterias () {
          var aux = []
          api.getMaterias()
            .then(response => {
              if (!response) return
              response.records.forEach(function (m) {
                aux.push({
                  id: m[0],
                  nombre: m[1]
                })
              })
            })
            .catch(error => {
              alert('Error' + error)
            })
          this.materias = aux
        },
        cargarCursos () {
          var aux = []
          api.getCursos()
            .then(response => {
              if (!response) return
              response.records.forEach(function (m) {
                aux.push({
                  id: m[0],
                  nombre: m[1],
                  turno: m[2]
                })
              })
            })
            .catch(error => {
              alert('Error' + error)
            })
          this.cursos = aux
        }
      }
    }
</script>
