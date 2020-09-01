class InvitefriendController < ApplicationController
    def new
        @email=params[:email]
        @user=params[:user]
        @game=params[:game]
        UserMailer.send_invitation(@email,@user,@game).deliver
        #redirect_to @user
    end
end
