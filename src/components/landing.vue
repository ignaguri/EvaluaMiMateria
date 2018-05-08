<template>
  <div class="">
    <!--<img src="../assets/background.jpg"/>-->
    <h1>{{ msg }}</h1>
    <button class="btn btn-info registrar" type="button" @click="registrarse">Registrarse</button>
    <button class="btn btn-success login" type="button" @click="login">Iniciar sesión</button>
  </div>
</template>

<script>
export default {
  name: 'Landing',
  data () {
    return {
      msg: 'Bienvenido a la App encuestadora'
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
</style>
