# This file is app/controllers/games_controller.rb
class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    id = params[:id]
    @game = Game.find(id)
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      if @game.game_file.attached?
        flash[:notice] = "Game #{@game.title} was added"
      else
        flash[:notice] = "'#{@game.title}' added, no file provided"
      end
      redirect_to games_path
    else
      flash[:notice] = @game.errors.full_messages
      redirect_to games_path
    end
  end
  
  def new
    
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
  
  private
    
  def game_params
    params.require(:game).permit(:title, :info, :game_file)
  end

end
