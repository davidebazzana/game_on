class TypingDnaController < ApplicationController
  skip_before_action :check_for_typing!, only: [:new, :create]

  def new
      @user = current_user
      
      authorize! :update, @user
  end
    
  def create
    
    key = ENV['KEY'].freeze
    @user = current_user

    authorize! :update, @user
    if params[:text] == ""
      flash[:error] = "Write down your email"
      redirect_to typing_dna_path
    elsif params[:tp] == ""
      flash[:error] = "Something went wrong!"
      redirect_to typing_dna_path
    end
    require 'net/http'

    apiKey = ENV["TYPINGDNA_API_KEY"]
    apiSecret = ENV["TYPINGDNA_API_SECRET"]
    id = BCrypt::Engine.hash_secret(@user.email, key)
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
      if !@user.enrolled?
        @user.enrolled = true
      end
      if !@user.typing_tries.blank?
        @user.typing_tries = 0
      end
      @user.save
      redirect_to games_path
    elsif parsed_json["action"] == "verify" && parsed_json["result"] == 0
      if @user.typing_tries.blank? || @user.typing_tries < 2
        @user.typing_tries = (@user.typing_tries || 0) + 1
        @user.enrolled = false
        @user.save
        flash[:error] = "Try again!"
        redirect_to typing_dna_path
      else
        flash[:error] = "Too many tries!"
        sign_out @user
        @user.lock_access! send_instruction: true
        redirect_to games_path
      end
    end
  end
end
