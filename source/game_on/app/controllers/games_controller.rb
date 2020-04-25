# This file is app/controllers/games_controller.rb
class GamesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @games = Game.all
  end

  def show
    id = params[:id]
    @game = Game.find(id)
  end

  def create
    @game = Game.new(params[:game].permit!)

    if @game.save
      flash[:notice] = "Game #{@game.title} was added"
      redirect_to games_path
    else
      flash[:notice] = @game.errors.full_messages
      redirect_to games_path
    end
  end

  def new
    
  end


  private
    
    def game_params
       params.require(:game).permit(:title, :info, :game_file)
    end

end