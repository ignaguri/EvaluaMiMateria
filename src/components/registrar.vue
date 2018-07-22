<template>
    <div class="container-fluid" style="padding-bottom: 30px;">
    <div class="row">
        <div class="col"></div>
        <div class="col-md-auto">
            <h1>Registrarme</h1>
        </div>
        <div class="col"></div>
    </div>
    <div class="row">
        <div class="col"></div>
        <div class="col-8">
            <form @submit.prevent="enviar">
                <div class="form-group">
                    <label for="txt_mail">Dirección de correo electrónico</label>
                    <input type="email" class="form-control" id="txt_mail" placeholder="Email" v-model="mail" required>
                    <small id="emailHelp" class="form-text text-muted">Ingrese la dirección de correo de la facultad.</small>
                </div>
                <div class="form-group">
                    <label for="txt_apellido">Apellido</label>
                    <input type="text" class="form-control" id="txt_apellido" placeholder="Apellido" v-model="apellido" required>
                </div>
                <div class="form-group">
                    <label for="txt_nombre">Nombre</label>
                    <input type="text" class="form-control" id="txt_nombre" placeholder="Nombre" v-model="nombre" required>
                </div>
                <div class="form-group">
                    <label for="txt_legajo">Legajo</label>
                    <input type="text" class="form-control" id="txt_legajo" placeholder="Legajo" v-model="legajo" required>
                </div>
                <div class="form-check form-check-inline" style="margin: 12px" v-for="rol in roles" :key="rol.id">
                    <input class="form-check-input" type="radio" :id="rol.nombre" :value="rol.id" v-model="rolE" required>
                    <label class="form-check-label" :for="rol.nombre">{{rol.nombre}}</label>
                </div>
                <div class="form-group">
                    <label for="txt_pass">Contraseña</label>
                    <input type="password" class="form-control" id="txt_pass" placeholder="Contraseña" minlength="6" v-model="pass" required>
                    <small id="passHelp" class="form-text text-muted">Debe tener al menos 6 caracteres.</small>
                </div>
                <div class="form-group">
                    <label for="txt_pass2">Repita la contraseña</label>
                    <input type="password" class="form-control" id="txt_pass2" placeholder="Contraseña" v-model="pass2" required>
                </div>
                <button type="submit" class="btn btn-success">Registrarme</button>
            </form>
        </div>
        <div class="col"></div>
    </div>
    </div>
</template>
<script>
/* eslint-disable indent */
    import api from '../api'
    export default {
      name: 'Login',
      data () {
        return {
          legajo: '',
          pass: '',
          pass2: '',
          roles: [{id: 2, nombre: 'Alumno'}, {id: 3, nombre: 'Profesor'}],
          nombre: '',
          apellido: '',
          mail: '',
          rolE: -1
        }
      },
      methods: {
        enviar () {
          if (this.pass !== this.pass2) {
            alert('Las contraseñas no coinciden')
            return
          }
          const data = {
            legajo: this.legajo,
            password: this.pass,
            nombre: this.nombre,
            apellido: this.apellido,
            mail: this.mail,
            idRol: this.rolE
          }
          const app = this
          api.registrar(data)
            .then(r => {
              if (r) {
                alert('Registrado con éxito')
                app.$router.push('/')
              } else {
                alert('Error al registrar')
                // app.$router.push('/')
              }
            })
        }
      }
    }

</script>
<style>
</style>
