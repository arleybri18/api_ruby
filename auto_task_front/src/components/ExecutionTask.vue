<template>
  <div>
    <section class="execution">
      <h1 class="font-weight-bold">TASK: {{ task.name }}</h1>
    </section>

    <section class="execution" v-if="result.state === 0">
      <div class="image">
        <img src="../assets/Pacman-1s-200px.svg" />
        <div style="background:url(../assets/Pacman-1s-200px.svg);background-repeat:repeat"></div>
        <p class="progress font-weight-bold">In progress!</p>
      </div>
    </section>

    <section class="execution" v-if="result.state === 1">
      <div class="image">
        <img src="../assets/ok-1.6s-200px.svg" />
        <div style="background:url(../assets/ok-1.6s-200px.svg);background-repeat:repeat"></div>
        <p>Load Successfull!</p>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: this.$route.params.id,
      task: {},
      result: {}
    };
  },
  methods: {},
  created() {
    const jwtHeader = {
      Authorization: "Bearer " + localStorage.getItem("idToken")
    };
    this.$http
      .get("http://localhost:3001/tasks/" + this.id, { headers: jwtHeader })
      .then(res => {
        //console.log(res.body);
        this.task = res.body;
      });
    this.result.state = 0;

    this.$http
      .post(
        "http://localhost:3001/executions/",
        { task_id: this.id, state: 0 },
        { headers: jwtHeader }
      )
      .then(res => {
        this.result = res.body;
        console.log(res.body);
      });
  }
};
</script>

<style>
.execution {
  background-color: rgba(29, 24, 24, 0.72);
  color: aliceblue;
  width: 50%;
  min-height: 25%;
  display: flex;
  flex-direction: column;
  margin-left: auto;
  margin-right: auto;
}
.image img {
  width: 45%;
  height: 45%;
}
.progress {
  color: #D6D6D6;
}
</style>