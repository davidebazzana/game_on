# This file is app/controllers/games_controller.rb
class GamesController < ApplicationController
  skip_before_action :save_last_url, only: [:like, :dislike]
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :require_permission, only: [:edit, :update, :destroy]
  respond_to do |format|
    format.js
  end
  
  def index
    @games = Game.all
  end

  def show
    respond_to do |format|
      format.html { @game = Game.find(params[:id]) } # show.html.haml
      format.json { send_build_file "json" }
    end
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    if @game.save
      if @game.files.attached?
        flash[:notice] = "'#{@game.title}' was added successfully"
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

    # delete any file attached
    @game.files.purge
    # destroy the game
    @game.destroy
    
    flash[:notice] = "'#{@game.title}' deleted successfully"
    redirect_to games_path
  end

  def launch
    cookies.signed[:game] = { value: params[:id], expires: 1.minute }
  end

  def download_loader
    send_build_file "UnityLoader.js"
  end
  
  def unity_build_files
    send_build_file params[:file_name].to_s
  end
  
  def like
    @game = Game.find(params[:id])
    if user_signed_in?
      if !current_user.liked? @game
        if current_user.disliked? @game
          @game.undisliked_by current_user
        end
        @game.liked_by current_user
      else
        @game.unliked_by current_user
      end
    else
      redirect_to login_path # not working...
    end
  end
  
  def dislike
    @game = Game.find(params[:id])
    if user_signed_in?
      if !current_user.disliked? @game
        if current_user.liked? @game
          @game.unliked_by current_user
        end
        @game.disliked_by current_user
      else
        @game.undisliked_by current_user
      end
    else
      redirect_to login_path # not working...
    end
  end
  
  private
    
  def game_params
    params.require(:game).permit(:title, :info, files: [])
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

  def send_build_file file_name
    if cookies.signed[:game] != nil
      game = Game.find(cookies.signed[:game])
      game.files.each do |file|
        if file.filename == file_name || file_name == "json" && file.filename.to_s.include?(".json")
          send_data file.download, filename: file.filename.to_s, content_type: file.content_type
          return
        end
      end
    end
    head :no_content # HTTP 204 no content
  end
  
end

