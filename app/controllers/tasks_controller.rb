class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /tasks
  def index
    @tasks = current_user.tasks
    puts @tasks.to_json
    if @tasks
      render json: @tasks
    else
      render json: []
    end
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
    # params[:task].merge(:user_id => current_user.id)
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], user_id: current_user.id)
    puts "esta es task #{@task}"
    if @task.save
      redirect_to tasks_path, format: :json
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
      @step = @task_data.steps
      @executions = @task_data.executions.order('id DESC')
      puts "este es executions"
      puts @executions
      @task = {id: @task_data.id, name: @task_data.name, 
              description: @task_data.description, steps: @step,
              executions: @executions,
              created_at: @task_data.created_at, updated_at: @task_data.updated_at}
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description)
    end
end
