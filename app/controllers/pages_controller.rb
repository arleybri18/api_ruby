class PagesController < ApplicationController
  before_action :set_page, only: [:show]
  before_action :authenticate_user

  # GET /pages/1
  def show
    if @page
      render json: @page
    else
      render json: []
    end
  end

  # POST /pages
  def create
    @page = Page.new(page_params)

    if @page.save
      render json: @page, status: :created, location: @page
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def page_params
      params.require(:page).permit(:url)
    end
end
