<template>
  <div class="container">
    <button class="btn btn-primary">
      <router-link v-bind:to="'/'">LOG OUT</router-link>
    </button>
    <section class="add-tasks">
      <h1>Add New Task</h1>
      <form v-on:submit="addTask">
        <input type="text" v-model="newTask.name" placeholder="Name" />
        <input type="text" v-model="newTask.description" placeholder="Description" />
        <button type="submit">CREATE TASK</button>
      </form>
    </section>

    <section class="task-list">
      <h1>Tasks list</h1>
      <ul>
        <li v-for="task in tasks">
          {{ task.name }} - {{ task.description }}
          <div>
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
          "http://localhost:3001/tasks/",
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
        .delete("http://localhost:3001/tasks/" + task.id, {
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
      .get("http://localhost:3001/tasks", { headers: jwtHeader })
      .then(res => (this.tasks = res.body));
  }
};
</script>

<style>
.add-tasks {
  background-color: rgba(29, 24, 24, 0.72);
  color: aliceblue;
  width: 50%;
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
input {
  height: 35px;
  padding: 5px 5px;
  margin: 10px 0px;
  background-color: #e0dada;
  border: none;
}
button,
a {
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

a:hover {
  text-decoration: none;
  background-color: #711f1b;
  color: #e0dada;
}

.task-list {
  background-color: rgba(24, 25, 29, 0.72);
  color: aliceblue;
  width: 70%;
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