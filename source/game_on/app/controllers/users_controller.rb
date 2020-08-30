class UsersController < ApplicationController

  def index
    @users = User.all
    @online_users = User.where("last_seen_at > ?", 2.minutes.ago)
  end

  def show
    @user = User.find(params[:id])
    @online_users = User.where("last_seen_at > ?", 5.minutes.ago)
    render :layout => "devise"
  end
  
end
