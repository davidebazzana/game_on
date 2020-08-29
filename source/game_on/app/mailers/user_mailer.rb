class UserMailer < ActionMailer::Base
  default from: 'Game_on@noreplay.com'
  def send_invitation(email,user)
    @email=email
    @user=user
    mail to: email , subject:"Invitation"
  end
end
