class InvitefriendController < ApplicationController
    def new
        @friend=User.find(params[:friend])
        @user=User.find(params[:user])
        @game=Game.find(params[:game])
        authorize! :invite, @friend
        UserMailer.send_invitation(@friend.email,@user.email,@game.title,@game.id).deliver
        #redirect_to @user
    end
end
