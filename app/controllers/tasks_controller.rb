class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # GET /tasks/'id'/steps
  def stepsByTask
    @task = Task.find(params[:id])
    render json: @task.step
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task_data.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task_data = Task.find(params[:id])
      @step = @task_data.step
      @task = {id: @task_data.id, name: @task_data.name, 
              description: @task_data.description, steps: @step,
              created_at: @task_data.created_at, updated_at: @task_data.updated_at}
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description, :enabled, :user_id)
    end
end
