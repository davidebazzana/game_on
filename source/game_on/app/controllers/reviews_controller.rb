class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_game

    def new
      authorize! :create, Review
      @review = Review.new
    end

    def create

      if params[:tp] != ""
        require 'net/http'
        
        apiKey = ENV["TYPINGDNA_API_KEY"]
        apiSecret = ENV["TYPINGDNA_API_SECRET"]
        id = current_user.email
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
        
        if parsed_json["action"] == "verify" && parsed_json["result"] == 0
          current_user.enrolled = false
          current_user.save
          flash[:warning] = "It seems like you're not you..."
          redirect_to typing_path(current_user)
          return
        end
      end
        
      authorize! :create, Review
      @review = Review.new(review_params)
      
      @review.user = current_user
      @review.game = @game
      
      if @review.save
        if @review.comments?
          flash[:notice] = "your review was added"
        else
          flash[:notice] = "Please insert your comment"
        end
        redirect_to game_path(@game)
      else
        flash[:error] = @review.errors.full_messages
        redirect_to games_path
      end
    end
   
    def index
      @reviews = Review.where(game_id: @game.id)
      authorize! :read, Review
    end

    # not implemented!
    def edit
    
    end

    # not implemented!
    def update
      authorize! :update, @review
      @review.update(review_params)
      respond_with(@review)
    end
  
    def destroy
      authorize! :destroy, @review
      @review.destroy
      redirect_to game_reviews_path(@game)
    end
    
    private
      def set_review
        @review = Review.find(params[:id])
      end

      def set_game
        @game = Game.find(params[:game_id])
      end

      def review_params
        params.require(:review).permit(:comments)
      end
end
    
    

