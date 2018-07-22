<template>
  <div class="container-fluid">
    <!--<img src="../assets/background.jpg" width="100%" height="50%"/>-->
    <h1 class="landing-title"><small>Bienvenido a</small><br><strong>EVALUÁ MI MATERIA</strong></h1>
    <button class="btn btn-info registrar" type="button" @click="registrarse">Registrarme</button>
    <button class="btn btn-success login" type="button" @click="login">Iniciar sesión</button>
  </div>
</template>

<script>
export default {
  name: 'Landing',
  data () {
    return {
    }
  },
  beforeRouteEnter (to, from, next) {
    next(vm => {
      const a = require('../api')
      a.default.logout(vm)
    })
  },
  methods: {
    registrarse () {
      this.$router.push('registrar')
    },
    login () {
      this.$router.push('login')
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.landing {
  position: relative;
  width: 50%;
}
.landing h1, h2 {
  /*font-weight: normal;*/
  position: absolute;
  top: 10%;
  left: 75%;
}
.landing img {
  width: 200%;
  height: auto;
}
.landing .registrar {
  position: absolute;
  top: 50%;
  left: 25%;
  transform: translate(100%, -100%);
  -ms-transform: translate(100%, -100%);
  /*background-color: #555;*/
  /*color: white;*/
  /*font-size: 16px;*/
  padding: 12px 24px;
  /*border: none;*/
  /*cursor: pointer;*/
  /*border-radius: 5px;*/
}
.landing .login {
  position: absolute;
  top: 50%;
  left: 100%;
  transform: translate(100%, -100%);
  -ms-transform: translate(100%, -100%);
  /*background-color: #555;*/
  /*color: white;*/
  /*font-size: 16px;*/
  padding: 12px 24px;
  /*border: none;*/
  /*cursor: pointer;*/
  /*border-radius: 5px;*/
}
.landing-title {
  margin: 10px;
  padding: 20px;
}
</style>
