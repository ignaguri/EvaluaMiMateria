<template>
    <div class="row">
        <div class="col"></div>
        <div class="col-md-auto">
            <form name="login_form" @submit.prevent="enviar">
                <div class="form-row">
                    <div class="form-group col-6">
                        <label for="inputEmail">Legajo</label>
                        <input type="text" class="form-control" id="inputEmail" placeholder="Legajo" v-model="legajo" v-focus required>
                    </div>
                    <div class="form-group col-6">
                        <label for="inputPassword">Contraseña</label>
                        <input type="password" class="form-control" id="inputPassword" placeholder="Contraseña" v-model="pass" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Entrar</button>
                <br>
                <div class="col">
                    <br>
                    <div v-if="error" class="alert alert-danger" role="alert">
                        {{errorText}}
                    </div>
                </div>
            </form>
        </div>
        <div class="col"></div>
    </div>
</template>
<script>
/* eslint-disable indent */
    import api from '../api'
    export default {
      name: 'Login',
      data () {
        return {
          legajo: null,
          pass: null,
          error: false,
          errorText: 'Usuario no encontrado'
        }
      },
      methods: {
        enviar () {
          const data = {
            legajo: this.legajo,
            pass: this.pass
          }
          const app = this
          // TODO: refactor this so 'r' is not that blackboxed
          api.login(data)
            .then(r => {
              if (!r[0]) {
                app.error = true
                app.errorText = r[1]
              } else {
                switch (r[2]) {
                  case 1:
                    app.$router.push('admin')
                    break
                  case 2:
                    app.$router.push('alumno/' + r[1])
                    break
                  case 3:
                    app.$router.push('profesor/' + r[1])
                    break
                }
              }
            })
        }
      },
      directives: {
        focus: {
          inserted: function (el) {
            el.focus()
          }
        }
      }
    }
</script>
<style>
</style>
