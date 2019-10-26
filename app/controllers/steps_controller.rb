load 'find_element'

class StepsController < ApplicationController

  before_action :set_step, only: [:show, :update, :destroy]

  # GET /steps
  def index
    @steps = Step.all

    render json: @steps
  end

  # GET /steps/1
  def show
    render json: @step
  end

  # POST /steps
  def create
    #include Find
    puts "Params"
    puts params
    puts "url:"
    puts params[:url]
    parameters = []
    parameters.push(params[:url])
    execution = false
    parameters.push(execution)
    parameters.push(params)
    puts "list to function"
    puts parameters
    
    if constructor_function(parameters) == nil
      puts 'nf'
      render json: 'Element not found'
    else
      puts 'step_params'
      puts step_params
      @step = Step.new(step_params)
      if @step.save
        puts 'save ok'
        render json: @step, status: :created, location: @step
      else
        puts 'error'
        render json: @step.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /steps/1
  def update
    if @step.update(step_params)
      render json: @step
    else
      render json: @step.errors, status: :unprocessable_entity
    end
  end

  # DELETE /steps/1
  def destroy
    @step.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_step
      @step = Step.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def step_params
      params.require(:step).permit(:name_elem, :elem_type, :elem_action, :task_id, :page_id, :text_elem)
    end
end
