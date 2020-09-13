class ContactadmController < ApplicationController
    def new
        @useremail=params[:useremail]
        UserMailer.contact_adm(@useremail).deliver
        flash[:notice] = "Your request was sent successfully"
    end
end
