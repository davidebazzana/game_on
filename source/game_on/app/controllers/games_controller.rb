# This file is app/controllers/games_controller.rb
class GamesController < ApplicationController
  skip_before_action :save_last_url, only: [:like, :dislike]
  skip_before_action :authenticate_user!, only: [:index, :show]
  # before_action :require_permission, only: [:edit, :update, :destroy]
  respond_to do |format|
    format.js
  end
  
  def index
    authorize! :read, Game
    if params[:game].nil?
      @games = Game.all
      @title = nil
      @category = nil
      @sorting_criteria = nil
    else
      @games = Game.search(search_game_params)
      @title = search_game_params[:title]
      @category = search_game_params[:category]
      @sorting_criteria = search_game_params[:sorting_criterion]
    end
  end

  def show
    respond_to do |format|
      format.html { 
        @game = Game.find(params[:id])
        authorize! :read, @game

        @favorite_exists = !(Favorite.where(user: current_user, favorited: @game) == [])
      } # show.html.haml
      format.json { send_build_file "json" }
    end
  end

  def create
    @game = Game.new(game_params)
    authorize! :create, Game
    @game.user = current_user

    begin
      @game.input_handler(params[:game])
    rescue ArgumentError => e
      flash[:error] = "Error while creating a new game: " + e.message
      redirect_to games_path
      return
    end

    @game.version = nil if game_params[:version].empty?
    if @game.save
      if @game.files.attached? && !@game.version.nil?
        flash[:notice] = "'#{@game.title}' v:#{@game.version} added successfully"
      elsif @game.files.attached? && @game.version.nil?
        flash[:notice] = "'#{@game.title}' added successfully, no version provided"
      elsif !@game.files.attached? && !@game.version.nil?
        flash[:notice] = "'#{@game.title}' v:#{@game.version} added, no file provided"
      else
        flash[:notice] = "'#{@game.title}' added, no version neither file provided"
      end
      redirect_to games_path
    else
      flash[:error] = @game.errors.full_messages
      redirect_to games_path
    end
    
  end

  def update
    @game = Game.find(params[:id])
    authorize! :update, @game

    begin
      @game.input_handler(params[:game])
    rescue ArgumentError => e
      flash[:error] = "Error while creating a new game: " + e.message
      redirect_to games_path
      return
    end

    if !params[:game][:files].nil? && params[:game][:files].length() == 5
        # Delete old files
        @game.files.purge
        # Attach new ones
        @game.files.attach(params[:game][:files])
    end
    if @game.update(edit_game_params)
      if edit_game_params[:version].empty?
        @game.version = nil
        @game.save
      end
      if params[:game][:files].nil?
        flash[:notice] = "'#{@game.title}' updated successfully"
      elsif params[:game][:files].length() == 5 && !@game.version.nil?
        flash[:notice] = "'#{@game.title}' updated successfully, released patch v:#{@game.version}"
      elsif params[:game][:files].length() == 5 && @game.version.nil?
        flash[:notice] = "'#{@game.title}' updated successfully, released new patch"
      else
        flash[:error] = "Error while releasing new patch: provide 5 files"
      end
      redirect_to games_path
    else
      flash[:error] = @game.errors.full_messages
      render 'edit'
    end
    
  end
  
  def new
    authorize! :create, Game
  end

  def edit
    @game = Game.find(params[:id])
    authorize! :update, @game
  end

  def destroy
    @game = Game.find(params[:id])
    authorize! :destroy, @game

    # delete any file attached
    @game.files.purge
    # destroy the game
    @game.destroy
    
    flash[:notice] = "'#{@game.title}' deleted successfully"
    redirect_to games_path
  end

  def launch
    authorize! :play, Game
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
    authorize! :vote, @game
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
    authorize! :vote, @game
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
    params.require(:game).permit(:title, :info, :category, :version, files: [])
  end

  # deprecated because of role model authorization
  def require_permission
    if current_user.id != Game.find(params[:id]).user_id
      flash[:warning] = "You must be the owner of the game to perform this action"
      redirect_to games_path
    end
  end

  def edit_game_params
    params.require(:game).permit(:title, :info, :category, :version)
  end

  def search_game_params
    params.require(:game).permit(:title, :category, :sorting_criterion)
  end

  def send_build_file file_name
    begin
      file = Game.build_file(file_name, cookies.signed[:game])
      send_data file.download, filename: file.filename.to_s, content_type: file.content_type
    rescue IOError => e
      head :no_content # HTTP 204 no content
    end
  end
end

