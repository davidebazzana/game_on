class FavoriteGamesController < ApplicationController
  before_action :set_game, only: :update

  def index
    @favorites = current_user.favorite_games
    authorize! :read_favorites_list, current_user
  end

  def update
    favorite = Favorite.where(favorited: @game, user: current_user)
    if favorite == []
      @favorite = Favorite.create(user: current_user, favorited: @game)
      authorize! :add_to_favorites, @game
      @favorite_exists = true
    else
      authorize! :remove_from_favorites, @game
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
