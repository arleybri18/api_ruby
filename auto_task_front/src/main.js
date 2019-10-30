// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'

import 'bootstrap';
import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'bootstrap/dist/css/bootstrap.min.css';

import VueResource from 'vue-resource';
import VueRouter from 'vue-router';
import BootstrapVue from 'bootstrap-vue'

Vue.config.productionTip = false
Vue.use(VueResource);
Vue.use(VueRouter);
Vue.use(BootstrapVue)

import Login from './components/Login.vue';
import Tasks from './components/Tasks.vue';
import EditTask from './components/EditTask.vue';
import Register from './components/Register.vue';


import ExecutionTask from './components/ExecutionTask'
import Default from './layouts/Default.vue';
import NoSidebar from './layouts/NoSidebar.vue';

Vue.component('default-layout', Default);
Vue.component('no-sidebar-layout', NoSidebar);

Vue.config.productionTip = false

const router = new VueRouter({
  mode: 'history',
  base: __dirname,
  routes: [
    {
      path: '/',
      meta: { layout: "no-sidebar"},
      component: Login,
    },
    {
      path: '/tasks',
      meta: { layout: "default"},
      component: Tasks,
    },
    {
      path: '/tasks/:id',
      meta: { layout: "default"},
      component: EditTask,
      props: true
    },
    {
      path: '/Register',
      meta: { layout: "no-sidebar"},
      component: Register
    },
    {
      path: '/execution/:id',
      meta: { layout: "default"},
      component: ExecutionTask,
      props: true
    }
  ]
})

/* eslint-disable no-new */
new Vue({
  router,
  el: '#app',
  components: { App },
  template: '<App/>'
}).$mount('#app')
