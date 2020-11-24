class ApplicationController < ActionController::Base
  before_action :save_last_url
  before_action :authenticate_user!
  before_action :update_last_seen_at, if: -> { user_signed_in? && (current_user.last_seen_at.nil? || current_user.last_seen_at < 5.minutes.ago) }
  before_action :check_for_typing!, if: -> { user_signed_in? && current_user.logs > 3}
  # before_action :configure_permitted_parameters, if: :devise_controller?
  
  helper_method :last_url, :favorite_text

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) do |user_params|
  #     user_params.permit(:username, :email)
  #   end
  # end

  def check_for_typing!
    if !current_user.enrolled? || (current_user.logs % 10) == 0
      flash[:warning] = "You have to demonstrate your identity!"
      redirect_to typing_dna_path
    end
  end

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


  def update_last_seen_at
    logger.info "Update last seen at timestamp for user id #{current_user.id}"
    current_user.update_attribute(:last_seen_at, Time.current)
  end
  
  def favorite_text
    return @favorite_exists ? 'Remove from favorites' : 'Add to favorites'

  end

  def after_sign_in_path_for(resource)
    if !resource.logs.blank?
      resource.logs += 1
      resource.save
    end
    if resource.persisted?
      if resource.enrolled? && (resource.logs % 10) != 0
        games_path
      else
        typing_dna_path
      end
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

end
