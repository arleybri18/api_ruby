<template>
  <div>
    <section>
      <h2>Login</h2>
      <form>
        <input type="email" v-model="user.email" placeholder="Email" />
        <input type="password" v-model="user.password" placeholder="Password" />
        <button v-on:click="onSubmit">Log in</button>
        <button>
          <router-link v-bind:to="'/Register'">Sign up</router-link>
        </button>
      </form>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      user: {},
      token: ""
    };
  },
  methods: {
    onSubmit(e) {
    e.preventDefault();
    // generate token for api
    console.log(`${this.user.email} ${this.user.password}`);
    this.$http.post(`${process.env.ROOT_API}/user_token/`, {
      auth: {
        email: this.user.email, 
        password: this.user.password
        }
      })
    .then(jwt => {
        // console.log(JSON.parse(JSON.stringify(jwt.data)).jwt);
        const data = JSON.parse(JSON.stringify(jwt.data))
        localStorage.setItem('idToken', data.jwt)
        const jwtHeader = {'Authorization': 'Bearer ' + localStorage.getItem('idToken')}
        console.log(localStorage.getItem('idToken'));
      if ( typeof localStorage.getItem('idToken') !== 'undefined' || localStorage.getItem('idToken') !== null) {
        this.$router.push({ path: "/tasks" });
        return this.$http.get(`${process.env.ROOT_API}/tasks/`, {headers: jwtHeader})
      };

      })
      .catch(err => {
        console.log(err)
        this.$router.push({ path: "/" })
        alert("Not Authorized");
      }); 
    
    }
  },
  created(){
    localStorage.removeItem('idToken');
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
section {
  border: solid 0.1rem #ff1D00;
  width: 50%;
  display: flex;
  flex-direction: column;
  margin-left: auto;
  margin-right: auto;
  padding: 1.5rem;
  font-size: 1.2rem;
}
form {
  display: flex;
  flex-direction: column;
  padding: 50px;
}
h2 {
  font-family: "Archivo Black", sans-serif;
  font-size:4rem;
  color: #be5256;
  padding: 0px 10px;
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
  margin: 20px 0px;
  font-weight: bold;
  background-color: #be5256;
  border: none;
  color: #e0dada;
  cursor: pointer;
  font-size: 16px;
  border-radius: 5px;
}

button:hover, a:hover {
  text-decoration: none;
  background-color: #772828;
  color: #e0dada;
  font-size: 1.1rem;
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
