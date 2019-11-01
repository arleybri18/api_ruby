<template>
  <nav class="navbar navbar-expand-lg navbar-light">
    <img width="70" height="70" src="../assets/logo.png" alt="">
    <a class="navbar-brand">
    <router-link v-bind:to="'/tasks'">AUTO-TASK</router-link></a>
    <button
      class="navbar-toggler"
      type="button"
      data-toggle="collapse"
      data-target="#navbarNavAltMarkup"
      aria-controls="navbarNavAltMarkup"
      aria-expanded="false"
      aria-label="Toggle navigation"
    >
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <div class="navbar-nav">
        <a class="nav-item nav-link active">
          <router-link v-bind:to="'/tasks'">HOME</router-link>
          <span class="sr-only">(current)</span>
        </a>
        <a class="nav-item nav-link"><router-link v-bind:to="'/'">LOG OUT</router-link></a>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  data() {
    return {
      open: false
    };
  }
};
</script>

<style>
.navbar {
  background-color: #be5256;
}
</style>