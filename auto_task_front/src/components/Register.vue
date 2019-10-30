<template>
  <div>
    <section>
      <h2>AuTo Task</h2>
      <form v-if="!submitted">
        <input type="fullname" v-model="user.fullname" placeholder="Fullname" />
        <input type="email" v-model="user.email" placeholder="Email" />
        <input type="password_digest" v-model="user.password_digest" placeholder="Password" />
        <button v-on:click.prevent="onSubmit">Register</button>
      </form>
      <div v-if="submitted">
         <h3>Registered</h3>
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
      this.$http.post("http://localhost:3001/users", {
        fullname: this.user.fullname,
        email: this.user.email,
        password_digest: this.user.password_digest,
        enabled: 1
      }).then(function(data){
        console.log(data);
        this.submitted = true;
      });
    }
  }
};
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
  background-image: url("https://images-assets.nasa.gov/image/6900952/6900952~orig.jpg");
  background-size: cover;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: #fff;
}
section {
  background-color: rgba(0, 0, 0, 0.72);
  width: 25%;
  min-height: 25%;
  display: flex;
  flex-direction: column;
  margin-left: auto;
  margin-right: auto;
}
form {
  display: flex;
  flex-direction: column;
  padding: 15px;
}
h2 {
  font-family: "Archivo Black", sans-serif;
  color: #e0dada;
  margin-left: auto;
  margin-right: auto;
}
input {
  height: 35px;
  padding: 5px 5px;
  margin: 10px 0px;
  background-color: #e0dada;
  border: none;
}
button {
  height: 40px;
  padding: 5px 5px;
  margin: 10px 0px;
  font-weight: bold;
  background-color: #be5256;
  border: none;
  color: #e0dada;
  cursor: pointer;
  font-size: 16px;
}
button:hover {
  background-color: #711f1b;
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