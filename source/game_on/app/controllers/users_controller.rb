# This file is app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, 
  only: [:show, :edit, :update, :destroy]
  before_action :last_url,
  only: [:new, :show]
  
  skip_before_action :require_login,
  only: [:new, :create]
  skip_before_action :save_last_url, only: [:create, :new, :show, :edit, :update]




  def index
    @users = User.all
  end

  def show
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User #{@user.username} was added"
      redirect_to last_url
    else
      flash[:warning] = @user.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(edit_user_params)
      flash[:notice] = "Your account is now changed!"
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def edit_user_params
      if params[:user][:password].blank?
        params[:user].delete(:password)
      end
      params.require(:user).permit(:username, :email)
    end

    def set_user
      @user = User.find(params[:id])
    end
end