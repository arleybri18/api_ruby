load 'find_element' 
class ExecutionsController < ApplicationController
  before_action :set_execution, only: [:show, :update, :destroy]

  # GET /executions
  def index
    @executions = Execution.all

    render json: @executions
  end

  # GET /executions/1
  def show
    render json: @execution
  end

  # POST /executions
  def create
    task = Task.find(params[:task_id])
    page_id = task.step[0].page_id
    page = Page.find(page_id)
    steps = task.step
    steps_list = []
    steps.map {|s| steps_list.push(s.attributes)}
    steps_list.unshift(true)
    steps_list.unshift(page.url)
    puts steps_list
    if constructor_function(steps_list, task.name) == nil
      puts 'An unexpected error '
      return nil
    else
      @execution = Execution.new(execution_params) 
      if @execution.save
        render json: @execution, status: :created, location: @execution
      else
        render json: @execution.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /executions/1
  def update
    if @execution.update(execution_params)
      render json: @execution
    else
      render json: @execution.errors, status: :unprocessable_entity
    end
  end

  # DELETE /executions/1
  def destroy
    @execution.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_execution
      @execution = Execution.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def execution_params
      params.require(:execution).permit(:state, :task_id)
    end
end
