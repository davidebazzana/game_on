# This file is app/controllers/games_controller.rb
class GamesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :require_permission, only: [:edit, :update, :destroy]
  
  def index
    @games = Game.all
  end

  def show
=begin
    byebug
    @game = Game.find(params[:id])
=end
    # @game = Game.find(params[:id])
    respond_to do |format|
      format.html { @game = Game.find(params[:id]) } # show.html.haml
      format.json { render json: File.read("#{Rails.root}/app/assets/javascripts/Build/DebugBuild.json") }
    end
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

  def unity_code
    @unityweb = "#{Rails.root}/app/assets/javascripts/Build/DebugBuild.wasm.code.unityweb"
    send_file(@unityweb)
  end

  def unity_framework
    @unityweb = "#{Rails.root}/app/assets/javascripts/Build/DebugBuild.wasm.framework.unityweb"
    send_file(@unityweb)
  end

  def unity_data
    @unityweb = "#{Rails.root}/app/assets/javascripts/Build/DebugBuild.data.unityweb"
    send_file(@unityweb)
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

