<template>
  <div>
    <section class="add-url">
      <h1>TASK: {{ task.name }}</h1>
      <form v-on:submit="addPage">
        <input id="url" type="text" v-model="newPage.url" placeholder="URL" />
        <button type="submit">ADD URL</button>
      </form>
    </section>

    <section class="step-list">
      <h1>Steps list</h1>

      <h4>
        Current URL:
        <span>{{ page.url }}</span>
      </h4>

      <form v-on:submit="addStep">
        <div class="row d-flex justify-content-center text-center">
          <label for="elementTypeSelect" class="col-sm-2 col-form-label">Element Type</label>
          <div class="col-sm-2">
            <select class="form-control" v-model="newStep.elem_type" id="elementTypeSelect">
              <option id="text_input">Text_input</option>
              <option id="title">Text</option>
              <option id="button">Button</option>
              <option id="table">Table</option>
            </select>
          </div>
          <div class="col-sm-3">
            <input
              type="text"
              class="form-control"
              v-model="newStep.name_elem"
              id="inputNameElem"
              placeholder="Name element"
            />
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
          <div class="col-sm-3">
            <input
              type="text"
              class="form-control"
              v-model="newStep.text_elem"
              id="inputTextElem"
              placeholder="Text element"
            />
          </div>
        </div>
        <button type="submit">ADD STEP</button>
      </form>
      <ul>
        <li v-for="s in steps">
          <b>Elemen type:</b>
          {{ s.elem_type }}
          <b>Name:</b>
          {{ s.name_elem }}
          <b>Action:</b>
          {{ s.elem_action }}
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
      const jwtHeader = {
        Authorization: "Bearer " + localStorage.getItem("idToken")
      };
      this.$http
        .post(
          "http://localhost:3001/pages/",
          { url: page.url },
          { headers: jwtHeader }
        )
        .then(res => (this.page = res.body));
      console.log("Page agregada");
    },
    addStep(e) {
      e.preventDefault();
      console.log("Agregar Step");
      const jwtHeader = {
        Authorization: "Bearer " + localStorage.getItem("idToken")
      };
      this.$http
        .post(
          "http://localhost:3001/steps/",
          {
            url: this.page.id,
            elem_type: this.newStep.elem_type,
            name_elem: this.newStep.name_elem,
            elem_action: this.newStep.elem_action,
            task_id: this.id,
            page_id: this.page.id
          },
          { headers: jwtHeader }
        )
        .then(res => {
          console.log("Step created");
          this.steps = res.body;
          this.newStep = {};
          this.getPage(this.steps);
        })
        .catch(err => {
          console.log(err);
          this.newStep = {};
          alert("Element not found, try again");
        });
    },
    deleteStep(step) {
      const jwtHeader = {
        Authorization: "Bearer " + localStorage.getItem("idToken")
      };
      this.$http
        .delete("http://localhost:3001/steps/" + step.id, {
          headers: jwtHeader
        })
        .then(res => {
          this.steps.splice(this.steps.indexOf(step), 1);
          if (this.steps === undefined) {
            this.steps = [];
          }
          alert("Step " + step.name_elem + " had been deleted!");
        });
      this.$http
        .get("http://localhost:3001/tasks/" + this.task.id, {
          headers: jwtHeader
        })
        .then(res => {
          this.steps = res.body.steps;
          this.getPage(this.steps);
        });
    },
    getPage(s) {
      //console.log(s[s.length - 1]);
      const jwtHeader = {
        Authorization: "Bearer " + localStorage.getItem("idToken")
      };
      this.$http
        .get("http://localhost:3001/pages/" + s[s.length - 1].page_id, {
          headers: jwtHeader
        })
        .then(res => {
          this.page = res.body;
          //console.log("Page")
          //console.log(res.body);
        })
        .catch((this.page = {}));
    }
  },
  created() {
    const jwtHeader = {
      Authorization: "Bearer " + localStorage.getItem("idToken")
    };
    this.$http
      .get("http://localhost:3001/tasks/" + this.id, { headers: jwtHeader })
      .then(res => {
        //console.log(res.body);
        this.task = res.body;
        //console.log(this.task);
        this.steps = this.task.steps;
        //console.log(this.task.steps);
        this.getPage(this.steps);
      });
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
