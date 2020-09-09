class UserMailer < ActionMailer::Base
  default from: 'Game_on@noreplay.com'
  def send_invitation(email,user,game,gameid)
    @email=email
    @user=user
    @game=game
    @gameid=gameid
    mail to: email , subject:"Invitation"
  end
end
