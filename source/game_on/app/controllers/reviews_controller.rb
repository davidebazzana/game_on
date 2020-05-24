class ReviewsController < ApplicationController
  before_action :set_review
  before_action :set_game

    def new
      
    end

    def create
      @review = Review.new(review_params)
      @review.user_id = current_user.id
      @review.game_id = @game.id

      if @review.save
        if @review.comments?
          flash[:notice] = "your review was added"
        else
          flash[:notice] = "Please insert your comment"
        end
        redirect_to games_path
      else
        flash[:error] = @review.errors.full_messages
        redirect_to games_path
      end
    end
   
    def show
      @reviews = Review.where(game_id: @game.id)
    end
    
    private
      def set_review
        @review = Review.find(params[:game_id])
      end

      def set_game
        @game = Game.find(params[:game_id])
      end

      def review_params
        params.require(:review).permit(:comments)
      end
end
    
    

