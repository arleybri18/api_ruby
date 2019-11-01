class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user, except: [:create]

  # POST /users
  def create
    puts "este es user_params"
    p user_params
    # @user = User.new(user_params)
    @user = User.new(
      fullname: params[:fullname],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      enabled: params[:enabled]
    )

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def find
    @user = User.find_by(email: params[:user][:email])
    if @user
      render json: @user
    else
      @errors = @user.errors.full_messages
      render json: @errors
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:fullname, :email, :password, :password_confirmation,  :enabled)
    end
end
