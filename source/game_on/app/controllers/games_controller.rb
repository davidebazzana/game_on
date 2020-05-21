# This file is app/controllers/games_controller.rb
class GamesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  skip_before_action :save_last_url, only: [:like, :dislike]
  before_action :require_permission, only: [:edit, :update, :destroy]
  respond_to do |format|
    format.js
  end
  
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params.merge(:user_id => session[:current_user_id]))

    if @game.save
      if @game.game_file.attached?
        flash[:notice] = "'#{@game.title}' was added"
      else
        flash[:notice] = "'#{@game.title}' added, no file provided"
      end
      redirect_to games_path
    else
      flash[:error] = @game.errors.full_messages
      redirect_to games_path
    end
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(edit_game_params)
      flash[:notice] = "'#{@game.title}' updated successfully"
      redirect_to games_path
    else
      flash[:error] = @game.errors.full_messages
      render 'edit'
    end
  end
  
  def new
  end

  def edit
    @game = Game.find(params[:id])
  end

  def destroy
    @game = Game.find(params[:id])

    # delete the file attached
    @game.game_file.purge
    # destroy the game
    @game.destroy
    
    flash[:notice] = "'#{@game.title}' deleted successfully"
    redirect_to games_path
  end

  def like
    @game = Game.find(params[:id])
    if !current_user.liked? @game
      if current_user.disliked? @game
        @game.undisliked_by current_user
      end
      @game.liked_by current_user
    else
      @game.unliked_by current_user
    end
  end
  
  def dislike
    @game = Game.find(params[:id])
    if !current_user.disliked? @game
      if current_user.liked? @game
        @game.unliked_by current_user
      end
      @game.disliked_by current_user
    else
      @game.undisliked_by current_user
    end
  end

  
  private
    
  def game_params
    params.require(:game).permit(:title, :info, :game_file, :user_id)
  end

  def require_permission
    if current_user.id != Game.find(params[:id]).user_id
      flash[:warning] = "You must be the owner of the game to perform this action"
      redirect_to games_path
    end
  end

  def edit_game_params
    params.require(:game).permit(:title, :info)
  end
  
end

