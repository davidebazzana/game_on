# This file is app/controllers/users_controller.rb
class UsersController < ApplicationController
    def index
      @users = User.all
    end
  
    def show
    end

    def new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        flash[:notice] = "User #{@user.username} was added"
        redirect_to users_path
      else
        flash[:notice] = @user.errors.full_messages
        redirect_to users_path
    end

    private

      def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end
    end
  end