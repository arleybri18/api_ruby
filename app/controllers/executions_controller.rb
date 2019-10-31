load 'find_element' 
class ExecutionsController < ApplicationController
  before_action :set_execution, only: [:show, :update, :destroy]
  before_action :authenticate_user

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
    page_id = task.steps[0].page_id
    page = Page.find(page_id)
    steps = task.steps
    steps_list = []
    steps.map {|s| steps_list.push(s.attributes)}
    steps_list.unshift(true)
    steps_list.unshift(page.url)
    puts steps_list
    res = constructor_function(steps_list, task.name)
    puts "this is the res"
    puts res
    links = {}
    res.each do |r|
      if r.class == Hash
        if r[:id]
          links[:id] = r[:id]
        else
          links[:table] = r[:table]
        end
      end
    end
    puts "this is link"
    puts links
    if res[0] == nil
      puts 'An unexpected error '
      return nil
    else
      @execution = Execution.new(execution_params)
      @execution[:result] = links
      @execution.state = 1;
      if @execution.save
        render json: @execution
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
