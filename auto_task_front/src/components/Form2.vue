<template>
  <!-- Default form register -->
  <form>
    <p class="h4 text-center mb-4">AuTo Task</p>
    <label for="defaultFormRegisterNameEx" class="grey-text">Fullname</label>
    <br/>
    <input type="email" id="defaultFormRegisterEmailEx" v-model="user.fullname" />
    <br/>
    <label class="grey-text">Email</label>
    <input type="email" id="defaultFormRegisterEmailEx" class="form-control"/>
    <br/>
    <input type="email" id="defaultFormRegisterConfirmEx" class="form-control"/>
    <br/>
    <label for="defaultFormRegisterPasswordEx" class="grey-text">Password</label>
    <input type="password" id="defaultFormRegisterPasswordEx" class="form-control"/>
    <div class="text-center mt-4">
      <button v-on:click="Register">Register</button>
    </div>
  </form>
  <!-- Default form register -->
</template>

<script>
export default {
  data() {
    return {
      user: {}
    };
  },
  methods: {
    Register(e) {
      e.preventDefault();
      console.log(this.user.email + " " + this.user.password);
      this.$router.push({ path: "/tasks" });
    }
  }
};
</script>
