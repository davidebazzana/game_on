class InvitefriendController < ApplicationController
    def new
        @friend=params[:friend]
        @user=params[:user]
        @game=params[:game]
        @gameid=params[:gameid]
        authorize! :invite, @friend
        UserMailer.send_invitation(@friend.email,@user,@game,@gameid).deliver
        #redirect_to @user
    end
end
