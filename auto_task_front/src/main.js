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

Vue.config.productionTip = false

const router = new VueRouter({
  mode: 'history',
  base: __dirname,
  routes: [
    {
      path: '/',
      component: Login,
    },
    {
      path: '/tasks',
      component: Tasks,
    },
    {
      path: '/tasks/:id',
      component: EditTask,
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
