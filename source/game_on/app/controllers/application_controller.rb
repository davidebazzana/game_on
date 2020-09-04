class ApplicationController < ActionController::Base
  before_action :save_last_url
  before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?
  
  helper_method :last_url, :favorite_text

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

  def favorite_text
    return @favorite_exists ? 'Remove from favorites' : 'Add to favorites'
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

end
