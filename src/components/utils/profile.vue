<template>
  <div>
    <a class="btn btn-sm btn-outline-dark" role="button" href="#" @click.prevent="volver">Volver</a>
      <div class="card border-dark mb-3" style="width: auto">
        <div class="card-header">Perfil de {{nombre}} {{apellido}}</div>
        <div class="card-body text-dark">
          <h5 class="card-title">Datos personales</h5>
          <p class="card-text">Nombre: <strong>{{nombre}}</strong></p>
          <p class="card-text">Apellido: <strong>{{apellido}}</strong></p>
          <p class="card-text">Legajo: <strong>{{legajo}}</strong></p>
          <p class="card-text">E-mail: <strong>{{mail}}</strong></p>
          <p class="card-text">Rol: <strong>{{rol}}</strong></p>
          <a class="btn btn-outline-primary" role="button" href="#" data-toggle="modal"
             data-target="#modalEditarPerfil">Editar información</a>
        </div>
      </div>
    <div class="modal" tabindex="-1" role="dialog" id="modalEditarPerfil">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Editar perfil</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-12">
                  <div class="form-group">
                    <label for="txt_nombre">Nombre</label>
                    <input type="text" class="form-control" id="txt_nombre" placeholder="Nombre" v-model="nombre" required>
                  </div>
                <div class="form-group">
                  <label for="txt_apellido">Apellido</label>
                  <input type="text" class="form-control" id="txt_apellido" placeholder="Apellido" v-model="apellido" required>
                </div>
                <div class="form-group">
                  <label for="txt_legajo">Legajo</label>
                  <input type="text" class="form-control" id="txt_legajo" placeholder="Legajo" v-model="legajo" required>
                </div>
                <div class="form-group">
                  <label for="txt_mail">Dirección de correo electrónico</label>
                  <input type="email" class="form-control" id="txt_mail" placeholder="Email" v-model="mail" required>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            <button type="submit" class="btn btn-success" data-dismiss="modal" @click="guardarPerfil">Guardar</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
/* eslint-disable indent */
  import api from '../../api'

  export default {
    props: [
      'id'
    ],
    data () {
      return {
        usuario: null,
        nombre: null,
        apellido: null,
        legajo: null,
        mail: null,
        rol: null
      }
    },
    mounted () {
      this.cargarUsuario()
    },
    methods: {
      cargarUsuario () {
        api.getUsuario(this.id)
          .then(r => {
            this.usuario = r
            this.nombre = r.nombre
            this.apellido = r.apellido
            this.legajo = r.legajo
            this.mail = r.mail
            this.rol = r.idRol === 2 ? 'Alumno' : 'Profesor'
          })
      },
      guardarPerfil () {
        if (!this.nombre || !this.apellido || !this.legajo || !this.mail) {
          alert('Debe completar todos los campos')
          return
        }
        const user = {
          id: this.id,
          nombre: this.nombre,
          apellido: this.apellido,
          legajo: this.legajo,
          mail: this.mail
        }
        api.editarPerfil(user)
          .then(r => {
            if (r) {
              alert('Cambios guardados! Por favor, inicie sesión nuevamente')
              api.logout(this)
            } else {
              alert('Error al guardar')
            }
          })
      },
      volver () {
        this.$parent.current = 'listaEncuestas'
      }
    }
  }
</script>
