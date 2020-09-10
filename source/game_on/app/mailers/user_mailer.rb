class UserMailer < ActionMailer::Base
  default from: 'Game_on@noreplay.com'
  def send_invitation(email,user,game,gameid)
    @email=email
    @user=user
    @game=game
    @gameid=gameid
    mail to: email , subject:"Invitation"
  end

  def send_report(devemail,useremail,game)
    @devemail=devemail
    @useremail=useremail
    @game=game
    mail to: devemail , subject:"Bug report"
  end
end
