class ContactadmController < ApplicationController
    def new
        @user=User.find(params[:user])
        UserMailer.contact_adm(@user.email).deliver
        flash[:notice] = "Your request was sent successfully"
    end
end
