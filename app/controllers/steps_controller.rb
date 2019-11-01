load 'find_element'

class StepsController < ApplicationController

  before_action :set_step, only: [:destroy]
  before_action :authenticate_user


  # POST /steps
  def create
    #include Find
    @url = Page.find(params[:url])
    parameters = []
    parameters.push(@url.url)
    execution = false
    parameters.push(execution)
    parameters.push(params)
    if params[:elem_type] == 'Text_input' &&  params[:name_elem] == nil
      list_elements = constructor_function(parameters)
      render json: list_elements[0]
    else
      list_elements = constructor_function(parameters)
      if list_elements == nil
        render json: 'Element not found', status: :unprocessable_entity
      else
        @step = Step.new(step_params)
        if @step.save
          @steps = Task.find(params[:task_id]).steps
          render json: @steps
        else
          render json: @step.errors, status: :unprocessable_entity
        end
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
