<template>
  <div>
    <section class="add-tasks">
      <h1>Add New Task</h1>
      <form v-on:submit="addTask">
        <input type="text" v-model="newTask.name" placeholder="Name" />
        <input type="text" v-model="newTask.description" placeholder="Description" />
        <button type="submit">CREATE TASK</button>
      </form>
    </section>

    <h1>Tasks list</h1>
    <ul>
      <li v-for="task in tasks">
        {{ task.name }} - {{ task.description }}
        <button v-on:click="deleteTask(task)">X</button>
      </li>
    </ul>
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
      console.log("Agregar Task");
      this.tasks.push(this.newTask);
      this.newTask = {};
    },
    deleteTask(task) {
      this.tasks.splice(this.tasks.indexOf(task), 1);
    }
  },
  created() {
    this.$http
      .get("http://localhost:3000/tasks")
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
</style>