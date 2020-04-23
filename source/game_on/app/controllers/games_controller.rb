# This file is app/controllers/games_controller.rb
class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    id = params[:id]
    @game = Game.find(id)
  end
end
