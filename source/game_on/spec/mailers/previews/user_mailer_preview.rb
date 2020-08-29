# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/signup_confirmation
  def signup_confirmation
    UserMailer.signup_confirmation
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/send_invitation
  def send_invitation
    UserMailer.send_invitation
  end

end
