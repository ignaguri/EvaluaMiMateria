<template>
    <div class="row">
        <div class="col"></div>
        <div class="col-md-auto">
            <form name="login_form" @submit.prevent="enviar">
                <div class="form-row">
                    <div class="form-group col-6">
                        <label for="inputEmail">Legajo</label>
                        <input type="text" class="form-control" id="inputEmail" placeholder="Legajo" v-model="legajo">
                    </div>
                    <div class="form-group col-6">
                        <label for="inputPassword">Password</label>
                        <input type="password" class="form-control" id="inputPassword" placeholder="Contraseña" v-model="pass">
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
            /*          fetch('http://localhost/encuestaVueWebpack/api.php',
             {
             headers: {
             'Accept': 'application/json',
             'Content-Type': 'application/json'
             },
             method: 'POST',
             body: JSON.stringify(obj)
             })
             .then(json)
             .then(function (data) {
             console.log('Request succeeded with JSON response', data)
             sessionStorage.setItem('csrf_token', data)
             })
             .catch(function (error) {
             console.log('Request failed', error)
             }) */
        }
      }
    }
    /*
     function status (response) {
     if (response.status >= 200 && response.status < 300) {
     return Promise.resolve(response)
     } else {
     return Promise.reject(new Error(response.statusText))
     }
     }
     */

    /*
     function json (response) {
     return response.json()
     }
     */
</script>
<style>
</style>
