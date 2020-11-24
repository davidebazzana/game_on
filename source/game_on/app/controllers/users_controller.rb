class UsersController < ApplicationController

  def index
    authorize! :read, User
    @users = User.all
    @online_users = User.where("last_seen_at > ?", 2.minutes.ago)
  end

  def show
    @user = User.find(params[:id])
    authorize! :read, @user
    @online_users = User.where("last_seen_at > ?", 5.minutes.ago)
    render :layout => "devise"
  end

  def admins
    authorize! :read, User
    @admins = User.where(role: "admin")
  end
  
end
