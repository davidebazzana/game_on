class LoginsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new

  end

  def create
    if user = 
      User.find_by_email(params[:login][:email]
      ).authenticate(params[:login][:password])

      session[:current_user_id] = user.id
      redirect_to games_path, notice: 'Logged in'
    else
      flash[:warning] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session.delete(:current_user_id)

    @_current_user = nil
    redirect_to games_path, notice: 'Logged out'
  end

  private

    
end
