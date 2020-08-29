class InvitefriendController < ApplicationController
    def new
        @email=params[:email]
        @user=params[:user]
        UserMailer.send_invitation(@email,@user).deliver
        #redirect_to @user
    end
end
