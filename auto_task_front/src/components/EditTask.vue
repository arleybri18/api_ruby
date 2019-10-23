<template>
  <div>
    <section class="add-url">
      <h1>TASK: {{ task.name }}</h1>
      <form v-on:submit="addPage">
        <input type="text" v-model="newPage.url" placeholder="URL" />
        <button type="submit">ADD URL</button>
      </form>
    </section>

    <section class="step-list">
      <h1>Steps list</h1>

      <h4>
        Current URL:
        <span>{{ page.id }}</span>
        <span>{{ page.url }}</span>
      </h4>

      <form v-on:submit="addStep">
        <div class="row d-flex justify-content-center text-center">
          <label for="elementTypeSelect" class="col-sm-2 col-form-label">Element Type</label>
          <div class="col-sm-2">
            <select class="form-control" v-model="newStep.elem_type" id="elementTypeSelect">
              <option id="unknow">Text_input</option>
              <option id="title">Text</option>
              <option id="button">Button</option>
              <option id="table">Table</option>
            </select>
          </div>
          <div class="col-sm-3">
            <input type="text" class="form-control" v-model="newStep.name_elem" id="inputNameElem" placeholder="Name element" />
          </div>
          <label for="elementActionSelect" class="col-sm-2 col-form-label">
            Element
            Action
          </label>
          <div class="col-sm-2">
            <select class="form-control" v-model="newStep.elem_action" id="elementActionSelect">
              <option>Click</option>
              <option>Copy</option>
              <option>Write</option>
            </select>
          </div>
        </div>
        <button type="submit">ADD STEP</button>
      </form>
      <ul>
        <li v-for="s in task.steps">
          <b>Elemen type:</b> {{ s.elem_type }}  <b>Name:</b> {{ s.name_elem }}  <b>Action:</b> {{ s.elem_action }}
          <div> 
            <button v-on:click="deleteStep(s)">DELETE</button>
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
      steps: [],
      page: {},
      newPage: {},
      newStep: {}
    };
  },
  methods: {
    addPage(e) {
      e.preventDefault();
      let page = this.newPage;
      this.$http.post("http://localhost:3000/pages/", {url: page.url})
      .then(res => (this.page = res.body));
      console.log("Add Page");
    },
    addStep(e) {
      e.preventDefault();
      console.log("Agregar Step");
      this.$http.post("http://localhost:3000/steps/", {elem_type: this.newStep.elem_type, 
      name_elem: this.newStep.name_elem, elem_action: this.newStep.elem_action,
      task_id: this.id, user_id: 1, page_id: this.page.id})
      .then(res => console.log("Step created"));
      this.task.steps.push(this.newStep);
      this.newStep = {};
    },
    deleteStep(step) {
      this.task.steps.splice(this.task.steps.indexOf(step), 1);
      this.$http.delete("http://localhost:3000/steps/"+step.id)
      .then(res => alert("Step "+ step.id + " deleted"));
    },
    getPage(){
      console.log(this.steps);
    // this.$http
    //   .get("http://localhost:3000/pages/" + this.task.steps[-1].page_id)
    //   .then(res => (this.page = res.body));
    }
  },
  created() {
    console.log("llegue " + this.id);
    this.$http
      .get("http://localhost:3000/tasks/" + this.id)
      .then(res => (this.task = res.body));

      this.getPage();

  }
};
</script>


<style>
.add-url {
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

.step-list {
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

.step-list ul {
  counter-reset: index;
  padding: 0;
}

.step-list ul li {
  counter-increment: index;
  display: flex;
  justify-content: space-around;
  padding: 12px 0;
  box-sizing: border-box;
}

/* Element counter */
.step-list ul li::before {
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
.step-list ul li + .step-list ul li {
  border-top: 1px solid rgba(255, 255, 255, 0.2);
}
</style>