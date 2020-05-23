class ReviewsController < ApplicationController


    def new
      
    end

    def create
    game_id = params[:game_id]
    user_id = session[:user_id]
    @game = Game.find(game_id) 

    @review = Review.new(params[:review].permit(:comments))

    @review.user_id = user_id
    @review.game_id = game_id
    @review.save!
    redirect_to game_path(@game) 
    end
   
    def show

      game_id = params[:game_id]
      @game = Game.find(game_id) 
      @review = Review.find(params[:game_id])
    end
    
    
    

end