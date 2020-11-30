# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  layout "devise"
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :configure_account_update_params, only: [:update]
  
  # GET /resource/sign_up
  def new
    authorize! :create, User
    super
  end

  # POST /resource
  def create
    authorize! :create, User
    super
    resource.update role: :player
  end

  # GET /resource/:id/edit
  def edit
    if !can? :assign_role, @user
      authorize! :update, @user
    else
      authorize! :assign_role, @user
    end
    # super
  end

  # PUT /resource/:id
  def update
    if !can? :assign_role, @user
      authorize! :update, @user
    else
      authorize! :assign_role, @user
    end
    old_email = @user.email
    email_changed = @user.email != params[:user][:email]
    is_oauth_account = !@user.provider.blank?

    successfully_updated = if can? :assign_role, @user
      @user.update_without_password account_update_params.except([:current_password, :email, :password, :password_confirmation])
    elsif !is_oauth_account
      @user.update_with_password account_update_params
    else
      @user.update_without_password account_update_params.except(:current_password)
    end
    if !successfully_updated
      render 'edit'
      return
    elsif current_user.role == "admin"
      redirect_to user_path(@user)
    else
      bypass_sign_in @user
      redirect_to root_path
    end
    if email_changed
      key = ENV['KEY'].freeze
      crypt = ActiveSupport::MessageEncryptor.new(key)
      require 'net/http'

      apiKey = ENV["TYPINGDNA_API_KEY"]
      apiSecret = ENV["TYPINGDNA_API_SECRET"]
      id = BCrypt::Engine.hash_secret(old_email, key)
      base_url = 'https://api.typingdna.com/changeuser/%s?'
      newuserid = BCrypt::Engine.hash_secret(params[:user][:email], key)
      uri = URI.parse(base_url%[id])
      http = Net::HTTP.new(uri.host)
      
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({'newuserid' => newuserid})
      request.basic_auth apiKey, apiSecret
      
      response = http.request(request)
      
      puts response.body
    end
  end

  # DELETE /resource/:id
  def destroy
    authorize! :destroy, @user
    super


    key = ENV['KEY'].freeze
    crypt = ActiveSupport::MessageEncryptor.new(key)
    require 'net/http'

    apiKey = ENV["TYPINGDNA_API_KEY"]
    apiSecret = ENV["TYPINGDNA_API_SECRET"]
    id = BCrypt::Engine.hash_secret(@user.email, key)
    base_url = 'https://api.typingdna.com/user/%s?'
    
    uri = URI.parse(base_url%[id])
    http = Net::HTTP.new(uri.host)
    
    request = Net::HTTP::Delete.new(uri.request_uri)
    request.basic_auth apiKey, apiSecret
    
    response = http.request(request)
    
    puts response.body
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

  def set_user
    @user = User.find(params[:id])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: extra_params)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    if can? :assign_role, @user
      devise_parameter_sanitizer.permit(:account_update, keys: [:role])
    else
      devise_parameter_sanitizer.permit(:account_update, keys: extra_params)
    end
  end

  def extra_params
    [:username]
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
