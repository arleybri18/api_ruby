<template>
    <div id="app">
      <vue-particles color="#dedede"></vue-particles>
      <router-view></router-view>
      <component :is="layout"></component>
    </div>
</template>

<script>
const default_layout = 'default';
import Login from './components/Login'
import Tasks from './components/Tasks'
import EditTask from './components/EditTask'
import Register from './components/Register'

export default {
  name: 'App',
  components: {
    Login,
    Tasks,
    Register
  },
  computed: {
    layout() {
      return (this.$route.meta.layout || default_layout) + '-layout';
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
  color: #D6D6D6;
}
html, body{
      width:100%;
      height:100%;
      margin:0px;
      font-family: 'Work Sans', sans-serif;
}

</style>