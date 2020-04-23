# This file is app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, 
  only: [:show, :edit, :update, :destroy]



  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User #{@user.username} was added"
      redirect_to users_path
    else
      flash[:warning] = @user.errors.full_messages
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end
end