class UsersController < ApplicationController

  def index
    authorize! :read, User
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize! :read, @user
    render :layout => "devise"
  end

  def admins
    authorize! :read, User
    @admins = User.where(role: "admin")
  end
  
end
