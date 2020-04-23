# This file is app/controllers/users_controller.rb
class UsersController < ApplicationController
    def index
      render html: 'users index'
    end
  
    def show
      render html: 'users show'
    end

    def new
      render html: 'users new'
    end
  end