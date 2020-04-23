# This file is app/controllers/users_controller.rb
class UsersController < ApplicationController
    def index
      @users = User.all
    end
  
    def show
      render html: 'users show'
    end

    def new
      
    end
  end