# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  layout "devise"
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    authorize! :update, User.find(current_user.id)
    super
  end

  # PUT /resource
  def update
    @user = User.find(current_user.id)
    authorize! :update, @user

    email_changed = @user.email != params[:user][:email]
    is_oauth_account = !@user.provider.blank?

    successfully_updated = if !is_oauth_account
      @user.update_with_password account_update_params
    else
      @user.update_without_password account_update_params.except(:current_password)
    end

    if successfully_updated
      bypass_sign_in @user
      redirect_to root_path
    else
      render 'edit'
    end
  end

  # DELETE /resource
  def destroy
    authorize! :destroy, User.find(current_user.id)
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
