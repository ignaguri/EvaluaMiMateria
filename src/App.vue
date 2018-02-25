<template>
  <div id="app">
    <nav class="navbar navbar-light bg-light">
        <img src="./assets/logo.png" class="d-inline-block align-top">
        <a @click.prevent="logout" href="">Salir</a>
    </nav>
    <!--<img src="./assets/logo.png" class="text-right">-->
      <!--<a @click.prevent="logout" href="">Salir</a>-->
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App',
  methods: {
    logout () {
      sessionStorage.clear()
      this.$router.push('/')
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
</style>
