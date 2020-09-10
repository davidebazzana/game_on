class ContactdevController < ApplicationController
    def new
        @devemail=params[:email]
        @game=params[:game]
        @useremail=params[:useremail]
        UserMailer.send_report(@devemail,@useremail,@game).deliver
        flash[:notice] = "Your report was sent successfully"
    end

end
