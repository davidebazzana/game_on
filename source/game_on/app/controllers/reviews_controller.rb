class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_game

    def new
      authorize! :create, Review
      @review = Review.new
    end

    def create
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
   
    def show
      @reviews = Review.where(game_id: @game.id)
    end

    def edit
    
    end

    def update
      authorize! :update, @review
      @review.update(review_params)
      respond_with(@review)
    end
  
    def destroy
      authorize! :destroy, @review
      @review.destroy
      respond_with(@review)
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
    
    

