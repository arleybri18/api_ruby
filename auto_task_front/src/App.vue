<template>
  <div id="app">
    <component :is="layout"> </component>
    <router-view></router-view>
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
    EditTask,
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
  color: #696666;
  margin-top: 6px;
}
html, body{
  background-image: url("./assets/particles.gif");
  background-repeat: no-repeat;
  background-size: cover;
	width:100%;
	margin:0px;
	font-family: 'Work Sans', sans-serif;
}
p {
  color: #696666;
}
</style>
