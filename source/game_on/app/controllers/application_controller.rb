class ApplicationController < ActionController::Base
  before_action :require_login
  private

  # Finds the User with ID stored in session
  # using the key :current_user_id 
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in 
        to access this section"
      redirect_to login_path
    end
  end

end
