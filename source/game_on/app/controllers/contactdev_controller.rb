class ContactdevController < ApplicationController
    def new
        @dev=User.find(params[:dev])
        @game=Game.find(params[:game])
        @user=User.find(params[:user])
        authorize! :contact, @dev
        UserMailer.send_report(@dev.email,@user.email,@game.title).deliver
        flash[:notice] = "Your report was sent successfully"
    end

end
