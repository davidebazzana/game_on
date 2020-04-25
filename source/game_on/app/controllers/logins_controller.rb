class LoginsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :save_last_url, only: [:new, :create]

  def new

  end

  def create
    pre_user = User.find_by_email(params[:login][:email])
    if pre_user && (user = pre_user.authenticate(params[:login][:password]))

      session[:current_user_id] = user.id
      redirect_to last_url, notice: 'Logged in'
    else
      flash[:warning] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session.delete(:current_user_id)

    @current_user = nil
    redirect_to games_path, notice: 'Logged out'
  end

  private

    
end
