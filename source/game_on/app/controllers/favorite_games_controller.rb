class FavoriteGamesController < ApplicationController
  before_action :set_game, only: :update

  def index
    @favorites = current_user.favorite_games
    authorize! :read, Favorite
  end

  def update
    favorite = Favorite.where(favorited: @game, user: current_user)
    authorize! :update, favorite
    if favorite == []
      Favorite.create(user: current_user, favorited: @game)
      @favorite_exists = true
    else
      favorite.destroy_all
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id] || params[:id])
  end
end
