class InvitefriendController < ApplicationController
    def new
        @email=params[:email]
        @user=params[:user]
        @game=params[:game]
        @gameid=params[:gameid]
        UserMailer.send_invitation(@email,@user,@game,@gameid).deliver
        #redirect_to @user
    end
end
