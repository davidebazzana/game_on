class UserMailer < ActionMailer::Base
  default from: 'Game_on@noreplay.com'
  def send_invitation(email,user,game)
    @email=email
    @user=user
    @game=game
    mail to: email , subject:"Invitation"
  end
end
