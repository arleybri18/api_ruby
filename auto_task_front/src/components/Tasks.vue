<template>
  <div class="container">
    <component :is="layout"></component>
    <section class="add-tasks">
      <h1 class="font-weight-bold">ADD NEW TASK</h1>
      <form v-on:submit="addTask">
        <input type="text" v-model="newTask.name" placeholder="Name" />
        <input type="text" v-model="newTask.description" placeholder="Description" />
        <button type="submit">CREATE TASK</button>
      </form>
    </section>

    <section class="task-list" v-if="tasks.length">
      <h1 class="font-weight-bold">MY TASKS</h1>
      <ul class="list-group">
        <li v-for="task in tasks" class="list-group-item bg-transparent align-items-start">
          <div class="d-flex justify-content-start">
          {{ task.name }} - {{ task.description }}
          </div>
          <div class="btn-group-sm align-items-start" role="group" aria-label="Basic example">
            <button>
              <router-link v-bind:to="'/tasks/' + task.id">EDIT</router-link>
            </button>
            <button v-on:click="deleteTask(task)">DELETE</button>
            <button>
              <router-link v-bind:to="'/execution/' + task.id">EXECUTE</router-link>
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
      tasks: [],
      newTask: {}
    };
  },
  methods: {
    addTask(e) {
      e.preventDefault();
      const jwtHeader = {
        Authorization: "Bearer " + localStorage.getItem("idToken")
      };
      console.log("Agregar Task");
      this.$http
        .post(
          `${process.env.ROOT_API}/tasks/`,
          { name: this.newTask.name, description: this.newTask.description },
          { headers: jwtHeader }
        )
        .then(res => {
          this.tasks = res.body;
          console.log("Task created");
          this.newTask = {};
        });
    },
    deleteTask(task) {
      const jwtHeader = {
        Authorization: "Bearer " + localStorage.getItem("idToken")
      };
      this.$http
        .delete(`${process.env.ROOT_API}/tasks/` + task.id, {
          headers: jwtHeader
        })
        .then(res => {
          this.tasks.splice(this.tasks.indexOf(task), 1);
          if (this.tasks === undefined) {
            this.tasks = [];
          }
          alert("Task " + task.name + " had been deleted!");
        });
    }
  },
  created() {
    const jwtHeader = {
      Authorization: "Bearer " + localStorage.getItem("idToken")
    };
    console.log(jwtHeader);
    this.$http
      .get(`${process.env.ROOT_API}/tasks`, { headers: jwtHeader })
      .then(res => (this.tasks = res.body))
      .catch(error => {
        if (error.status === 401) {
          this.$router.push({ path: "/" });
          alert("Not Authorized");
        } else {
          console.log(error);
        }
      });
  }
};
</script>

<style scoped>

.add-tasks {
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
  font-size: 1.2rem;
}
input {
  height: 35px;
  padding: 1.6rem 5px;
  margin: 20px 0px;
  background-color: transparent;
  border: solid 0.1rem #FF1D00;
  border-radius: 5px;
  font-size: 1.5rem;
}

button,
a {
  height: 50px;
  margin: 15px 0px;
  font-weight: bold;
  background-color: #be5256;
  border: none;
  color: #e0dada;
  cursor: pointer;
  font-size: 1rem;
  border-radius: 5px;
}

button:hover {
  background-color: #772828;
  color: #e0dada;
  font-size: 1.1rem;
}

a:hover {
  text-decoration: none;
  background-color: #772828;
  color: #e0dada;
  border: none;
  font-size: 1.1rem;
}

.task-list {
  border: solid 1px #ff1d00;
  width: 80%;
  min-height: 25%;
  display: flex;
  flex-direction: column;
  margin-top: 30px;
  margin-left: auto;
  margin-right: auto;
}

.task-list ul {
  counter-reset: index;
  padding: 0;
}

.task-list ul li {
  counter-increment: index;
  display: flex;
  justify-content: space-around;
  padding: 12px 0;
  box-sizing: border-box;
  font-size: 1.5rem;
}

/* Element counter */
.task-list ul li::before {
  content: counters(index, ".", decimal-leading-zero);
  font-size: 1.5rem;
  text-align: right;
  font-weight: bold;
  min-width: 50px;
  padding-right: 12px;
  font-variant-numeric: tabular-nums;
  align-self: flex-start;
  background-image: linear-gradient(to bottom, aquamarine, orangered);
  background-attachment: fixed;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

/* Element separation */
.task-list ul li + .task-list ul li {
  border-top: 1px solid rgba(255, 255, 255, 0.2);
}
</style>