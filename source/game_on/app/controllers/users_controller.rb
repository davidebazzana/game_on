class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:typing_new, :typing_create]
  skip_before_action :check_for_typing!, only: [:typing_new, :typing_create]

  def index
    authorize! :read, User
    @users = User.all
    @online_users = User.where("last_seen_at > ?", 2.minutes.ago)
  end

  def show
    @user = User.find(params[:id])
    authorize! :read, @user
    @online_users = User.where("last_seen_at > ?", 5.minutes.ago)
    render :layout => "devise"
  end

  def admins
    authorize! :read, User
    @admins = User.where(role: "admin")
  end
  
  def typing_new
    @user = User.find(params[:id])
    authorize! :update, @user
  end
  
  def typing_create
    @user = User.find(params[:id])
    authorize! :update, @user
    if params[:text] == ""
      flash[:error] = "Write down your email"
      redirect_to typing_path(@user)
    elsif params[:tp] == ""
      flash[:error] = "Something went wrong!"
      redirect_to typing_path(@user)
    end
    require 'net/http'

    apiKey = ENV["TYPINGDNA_API_KEY"]
    apiSecret = ENV["TYPINGDNA_API_SECRET"]
    id = @user.email
    base_url = 'https://api.typingdna.com/%s/%s'
    tp = params[:tp]
    
    uri = URI.parse(base_url%['auto',id])
    http = Net::HTTP.new(uri.host)
    
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({'tp' => tp})
    request.basic_auth apiKey, apiSecret
    
    response = http.request(request)

    puts response.body
    
    parsed_json = ActiveSupport::JSON.decode(response.body)

    if parsed_json["action"] == "enroll" && parsed_json["status"] == 200
      redirect_to games_path
    elsif parsed_json["action"] == "verify;enroll" && parsed_json["result"] == 1
      redirect_to games_path
      if !@user.enrolled?
        @user.enrolled = true
        @user.save
      end
    elsif parsed_json["action"] == "verify" && parsed_json["result"] == 0
      if !@user.typing_tries? || @user.typing_tries < 2
        @user.typing_tries = (@user.typing_tries || 0) + 1
        @user.save
        flash[:error] = "Try again!"
        redirect_to typing_path(@user)
      else
        flash[:error] = "Too many tries!"
        sign_out @user
        lock_access! @user
        redirect_to games_path
      end
    end
  end
  
end
