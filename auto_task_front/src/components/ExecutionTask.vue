<template>
  <div>
    <section class="execution">
      <h1 class="font-weight-bold">TASK: {{ task.name }}</h1>
    </section>

    <section class="execution" v-if="result.state === 0">
      <div class="image">
        <img src="../assets/Pacman-1s-200px.svg" />
        <div style="background:url(../assets/Pacman-1s-200px.svg);background-repeat:repeat"></div>
      </div>
    </section>

    <section class="execution" v-if="result.state === 1">
      <div class="image">
        <img src="../assets/ok-1.6s-200px.svg" />
        <div style="background:url(../assets/ok-1.6s-200px.svg);background-repeat:repeat"></div>
      </div>
    </section>

    <section class="execution-result">
      <h1 class="font-weight-bold">MY EXECUTIONS</h1>
      <ul class="list-group">
        <li v-for="e in executions" class="list-group-item bg-transparent">
          <div class="d-flex justify-content-around align-items-center">
            <b>Date:</b>
            {{ e.created_at }}
            <span v-if="e.state === 1">
              <b>Status:</b> Success
            </span>
            <span v-if="e.state === 0">
              <b>Status:</b> Error
            </span>
            <b>Result:</b>
            <button v-if="e.result.table">
              <a :href="e.result.table" target="_blank">DOCUMENT</a>
            </button>
            <button v-if="e.result.id">
              <a :href="e.result.id" target="_blank">DOCUMENT</a>
            </button>
          </div>
        </li>
      </ul>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: this.$route.params.id,
      task: {},
      result: {},
      executions: []
    };
  },
  methods: {},
  created() {
    const jwtHeader = {
      Authorization: "Bearer " + localStorage.getItem("idToken")
    };
    this.$http
      .get(`${process.env.ROOT_API}/tasks/` + this.id, { headers: jwtHeader })
      .then(res => {
        this.task = res.body;
        this.executions = this.task.executions;
      });
    this.result.state = 0;

    this.$http
      .post(
        `${process.env.ROOT_API}/executions/`,
        { task_id: this.id, state: 0 },
        { headers: jwtHeader }
      )
      .then(res => {
        // set execution
        this.result = res.body;
        // refresh list
        this.$http
          .get(`${process.env.ROOT_API}/tasks/` + this.id, {
            headers: jwtHeader
          })
          .then(res => {
            this.task = res.body;
            this.executions = this.task.executions;
          });
      });
  }
};
</script>

<style>
.execution {
  color: #4a4343;
  width: 50%;
  min-height: 50%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  margin-left: auto;
  margin-right: auto;
}

.execution-result {
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
  background-color: #4a4343;
  border: solid 1px #be5256;
  color: #be5256;
}

a:hover {
  text-decoration: none;
  background-color: #4a4343;
  border: solid 1px #be5256;
  color: #be5256;
}
.image img {
  width: 45%;
  height: 45%;
}
</style>