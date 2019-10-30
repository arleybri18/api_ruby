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
import ExecutionTask from './components/ExecutionTask'

export default {
  name: 'App',
  components: {
    Login,
    Tasks
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
}
</style>
