class InvitefriendController < ApplicationController
    def new
        @email=params[:email]
        @user=params[:user]
        @game=params[:game]
        @gameid=params[:gameid]
        authorize! :invite, @user
        UserMailer.send_invitation(@email,@user,@game,@gameid).deliver
        #redirect_to @user
    end
end
