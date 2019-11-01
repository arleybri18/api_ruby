<template>
  <div>
    <section>
      <h2>A u T o - T a s k</h2>
      <form v-if="!submitted" id="app" @submit="checkForm">
        <input type="fullname" v-model="user.fullname" placeholder="Fullname" />
        <input type="email" v-model="user.email" placeholder="Email" />
        <input type="password" v-model="user.password" placeholder="Password" />
        <input type="password" v-model="user.password_conf" placeholder="Password" />
        <button v-on:click.prevent="onSubmit">Register</button>
        <button><router-link v-bind:to="'/'">Log In</router-link></button>
      </form>

      <div v-if="submitted">
         <h3>Registered</h3>
         <button><router-link v-bind:to="'/'">Log In</router-link></button>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: {},
      submitted: false,
    }
  },
  methods: {
    onSubmit(e) {
      this.$http.post(`${process.env.ROOT_API}/users`, {
        fullname: this.user.fullname,
        email: this.user.email,
        password: this.user.password,
        password_confirmation: this.user.password_conf,
        enabled: 1
      }).then(function(data){
        console.log(data);
        this.submitted = true;
      });
    }
  },
}

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
html,
body {
  width: 100%;
  height: 100%;
  margin: 0px;
  font-family: "Work Sans", sans-serif;
}
body {
  background-size: cover;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: #fff;
}
section {
  background-color: rgba(0, 0, 0, 0);
  width: 50%;
  border: solid 0.1rem #FF1D00;
  min-height: 100%;
  display: flex;
  flex-direction: column;
  margin-left: auto;
  margin-right: auto;
  padding: 1.5rem;
}

form {
  display: flex;
  flex-direction: column;
  padding: 50px;
}

h2 {
  font-family: "Archivo Black", sans-serif;
  font-size: 4rem;
  color: #be5256;
  padding: 50px 10px;
  margin-left: auto;
  margin-right: auto;
}

input {
  height: 35px;
  padding: 1.6rem 5px;
  margin: 20px 0px;
  background-color: transparent;
  border: solid 0.1rem #FF1D00;
  border-radius: 5px;
}

button,
a {
  height: 50px;
  padding: 0rem 10rem;
  margin: 20px 0px;
  font-weight: bold;
  background-color: #be5256;
  border: none;
  color: #e0dada;
  cursor: pointer;
  font-size: 16px;
  border-radius: 5px;
}

button:hover {
  background-color: #711f1b;
}

a:hover {
  text-decoration: none;
  background-color: #711f1b;
  color: #e0dada;
}
@-webkit-keyframes shake {
  from,
  to {
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
  }
  10%,
  30%,
  50%,
  70%,
  90% {
    -webkit-transform: translate3d(-10px, 0, 0);
    transform: translate3d(-10px, 0, 0);
  }
  20%,
  40%,
  60%,
  80% {
    -webkit-transform: translate3d(10px, 0, 0);
    transform: translate(10px, 0, 0);
  }
}
.shake {
  animation-name: shake;
  animation-duration: 1s;
  /*animation-fill-mode: both;*/
}
@media screen and (max-width: 780px) {
  section {
    width: 90%;
  }
}
</style>