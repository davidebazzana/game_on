class UserMailer < ActionMailer::Base
  default from:"Game_on@noreplay.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_invitation.subject
  #
  def send_invitation(email,user)
    @email=email
    @user=user
    mail to: email , subject:"Invitation"
  end
end
