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
  margin-top: 60px;
}
html, body{
<<<<<<< HEAD
      background-image: url("./assets/back4.jpg");
      background-repeat: no-repeat;
      background-size: contain;
      width:100%;
      height:100%;
      margin:0px;
      font-family: 'Work Sans', sans-serif;
=======
  /* background-color: #D6D6D6; */
  background-image: url("./assets/bg_table.jpeg");
  background-repeat: no-repeat;
  background-size: cover;
	width:100%;
	height:100%;
	margin:0px;
	font-family: 'Work Sans', sans-serif;
}
p {
  color: #4A4343;
>>>>>>> db3a20345ba9e3c170d9d9e70cff5d68cc30eb2f
}
</style>
