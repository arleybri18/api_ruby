<template>
  <div>
    <h1>Edit task {{ id }}</h1>
    <div class="container mt-3">
      <div class="row">
        <div class="col-sm">
          <form>
            <div class="card">
              <div class="card-header">
                <div class="form-group row">
                  <label for="inpuTask" class="col-sm-1 col-form-label">Task:</label>
                  <div class="col-sm-8">
                    <input
                      type="text"
                      class="form-control"
                      id="inpuTask"
                      placeholder="Enter Name of Task"
                    />
                  </div>
                </div>
              </div>
              <div class="card-body">
                <h5 class="card-title">Steps</h5>

                <div class="form-group row">
                  <label for="inputURL" class="col-sm-1 col-form-label">URL</label>
                  <div class="col-sm-8">
                    <input type="url" class="form-control" id="inputURL" placeholder="Enter URL" />
                  </div>
                  <button class="btn" id="add">
                    Add Step
                    <i class="fa fa-plus-circle fa-lg"></i>
                  </button>
                </div>
                <div id="steps">
                  <div class="step" id="step_0">
                    <label for="elementTypeSelect" class="col-sm-2 col-form-label">Element Type</label>
                    <div class="col-sm-2">
                      <select class="form-control" id="elementTypeSelect">
                        <option id="unknow">Unknow</option>
                        <option id="title">Title</option>
                        <option id="button">Button</option>
                        <option id="table">Table</option>
                      </select>
                    </div>
                    <div class="col-sm-2">
                      <input
                        type="text"
                        class="form-control"
                        id="inputNameElem"
                        placeholder="Name element"
                      />
                    </div>
                    <button class="btn search" id="search">
                      <i class="fa fa-search fa-lg"></i>
                    </button>
                    <label for="elementActionSelect" class="col-sm-2 col-form-label">
                      Element
                      Action
                    </label>
                    <div class="col-sm-2">
                      <select class="form-control" id="elementActionSelect">
                        <option>Unknow</option>
                      </select>
                    </div>
                  </div>
                </div>
                <div class="d-flex flex-row-reverse bd-highlight">
                  <div class="p-2 bd-highlight">
                    <button type="submit" class="btn">
                      <i class="fa fa-save fa-2x"></i>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: this.$route.params.id,
      tasks: [],
      newTask: {}
    };
  },
  methods: {},
  created() {
    console.log("llegue " + this.id)
    this.$http
      .get("http://localhost:3000/tasks")
      .then(res => (this.tasks = res.body));
  },
  props: ['id']
};
</script>

<style>
</style>