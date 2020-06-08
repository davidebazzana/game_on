class ApplicationController < ActionController::Base
  before_action :save_last_url
  before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?
  
  helper_method :last_url

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) do |user_params|
  #     user_params.permit(:username, :email)
  #   end
  # end

  def save_last_url
    if request.path != "/login" && 
      request.path != "/signup"
      session[:last_url] = request.fullpath
    end
  end

  def last_url
    @last_url = session[:last_url]
    @last_url ||= games_path
  end

end
