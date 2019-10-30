load 'find_element'

class StepsController < ApplicationController

  before_action :set_step, only: [:show, :update, :destroy]
  before_action :authenticate_user

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
    @url = Page.find(params[:url])
    puts @url.url
    parameters = []
    parameters.push(@url.url)
    execution = false
    parameters.push(execution)
    parameters.push(params)
    puts "list to function"
    puts parameters
    puts parameters[2].class
    if constructor_function(parameters) == nil
      puts 'nf'
      render json: 'Element not found', status: :unprocessable_entity
    else
      puts 'step_params'
      puts step_params
      @step = Step.new(step_params)
      if @step.save
        puts 'save ok'
        @steps = Step.where(params[:task_id])
        render json: @steps
      else
        puts 'error'
        render json: @step.errors, status: :unprocessable_entity
      end
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
