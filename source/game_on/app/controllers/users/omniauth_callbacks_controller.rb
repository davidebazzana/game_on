# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    authorize! :create, User
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.provider.blank?
      @user.update(provider: request.env['omniauth.auth'].provider, uid: request.env['omniauth.auth'].uid)
    end

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join
    end
    
  end

  def github
    authorize! :create, User
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.provider.blank?
      @user.update(provider: request.env['omniauth.auth'].provider, uid: request.env['omniauth.auth'].uid)
    end

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      session['devise.github_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join
    end
    
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
