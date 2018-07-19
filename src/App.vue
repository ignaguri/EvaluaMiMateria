<template>
  <div id="app">
    <nav class="navbar navbar-light bg-light">
        <img src="./assets/logo.png" class="d-inline-block align-top logo-img">
        <a @click.prevent="logout" href="">Salir</a>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
import api from './api'
export default {
  name: 'App',
  methods: {
    logout () {
      api.logout(this)
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /*margin-top: 60px;*/
}
.logo-img {
    width: auto;
    max-height: 64px;
}

@media (max-width: 640px) {
    .logo-img {
        max-height: 40px;
    }
}
</style>
