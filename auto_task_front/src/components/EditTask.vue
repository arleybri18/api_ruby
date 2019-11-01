<template>
  <div>
    <section class="add-url">
      <h1 class="font-weight-bold">TASK: {{ task.name }}</h1>
      <form v-on:submit="addPage">
        <input id="url" type="text" v-model="newPage.url" placeholder="URL" />
        <button type="submit">ADD URL</button>
      </form>
    </section>

    <section class="step-list">
      <h1 class="font-weight-bold">STEPS</h1>

      <h4 class="font-weight-bold">
        Current URL:
        <span>{{ page.url }}</span>
      </h4>

      <form v-on:submit="addStep">
        <div class="row d-flex justify-content-center align-items-center">
          <label for="elementTypeSelect" class="col-sm-2 col-form-label">Element Type</label>
          <div class="col-sm-2">
            <select
              class="form-control"
              @change="getType($event)"
              v-model="newStep.elem_type"
              id="elementTypeSelect"
            >
              <option id="text_input">Text_input</option>
              <option id="title">Text</option>
              <option id="button">Button</option>
              <option id="table">Table</option>
            </select>
          </div>
          <div class="col-sm-3" v-if="newStep.elem_type !== 'Text_input'">
            <input
              type="text"
              class="form-control"
              v-model="newStep.name_elem"
              id="inputNameElem"
              placeholder="Name element"
            />
          </div>
          <div class="col-sm-3" v-if="newStep.elem_type === 'Text_input'">
            <select class="form-control" v-model="newStep.name_elem" id="elementInputSelect">
              <option v-for="el in nameElems">{{el}}</option>
            </select>
          </div>
          <label for="elementActionSelect" class="col-sm-2 col-form-label">
            Element
            Action
          </label>
          <div class="col-sm-2">
            <select class="form-control" v-model="newStep.elem_action" id="elementActionSelect">
              <option v-if="newStep.elem_type === 'Button'">Click</option>
              <option v-if="newStep.elem_type === 'Table' || newStep.elem_type === 'Text'">Copy</option>
              <option v-if="newStep.elem_type === 'Text_input'">Write</option>
            </select>
          </div>
          <div class="col-sm-3" v-if="newStep.elem_type === 'Text_input'">
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
      <ul  class="list-group">
        <li v-for="s in steps"  class="list-group-item bg-transparent">
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
      nameElems: [],
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
          `${process.env.ROOT_API}/pages/`,
          { url: page.url },
          { headers: jwtHeader }
        )
        .then(res => (this.page = res.body));
      console.log("Page agregada");
      this.newPage.url = "";
    },
    addStep(e) {
      e.preventDefault();
      console.log("Agregar Step");
      const jwtHeader = {
        Authorization: "Bearer " + localStorage.getItem("idToken")
      };
      this.$http
        .post(
          `${process.env.ROOT_API}/steps/`,
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
        .delete(`${process.env.ROOT_API}/steps/` + step.id, {
          headers: jwtHeader
        })
        .then(res => {
          this.steps.splice(this.steps.indexOf(step), 1);
          // console.log(this.steps);
          if (this.steps === undefined) {
            this.steps = [];
            this.page = {};
          }
          alert("Step " + step.name_elem + " had been deleted!");
        });
      this.$http
        .get(`${process.env.ROOT_API}/tasks/` + this.task.id, {
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
        .get(`${process.env.ROOT_API}/pages/` + s[s.length - 1].page_id, {
          headers: jwtHeader
        })
        .then(res => {
          this.page = res.body;
          //console.log("Page")
          //console.log(res.body);
        })
        .catch((this.page = {}));
    },
    getType(event) {
      const jwtHeader = {
        Authorization: "Bearer " + localStorage.getItem("idToken")
      };
      let elem = event.target.value;
      // console.log(elem);
      if (elem === "Text_input") {
        this.$http
          .post(
            `${process.env.ROOT_API}/steps/`,
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
            console.log("Call steps");
            // console.log(res.body);
            this.nameElems = res.body;
          })
          .catch(err => {
            console.log(err);
            alert("Element not found, try again");
          });
      } else {
        this.nameElems = [];
        this.newStep.name_elem = null;
      }
    }
  },
  created() {
    const jwtHeader = {
      Authorization: "Bearer " + localStorage.getItem("idToken")
    };
    this.$http
      .get(`${process.env.ROOT_API}/tasks/` + this.id, { headers: jwtHeader })
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
  padding: 20px;
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

.step-list {
  width: 60%;
  border: solid 0.1rem #FF1D00;
  min-height: 100%;
  display: flex;
  font-size: 1.2rem;
  flex-direction: column;
  margin-left: auto;
  margin-right: auto;
  margin-top: 20px;
  padding: 1.5rem;
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

.col-form-label {
  color: #be5256;
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
