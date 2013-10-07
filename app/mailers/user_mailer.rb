class UserMailer < ActionMailer::Base
  default from: "user-mailer@piousbox.com"

  def welcome_email(user)
    @user = user
    @url = 'http://piousbox.com/en/users/sign_in'
    mail( :to => user.email, :subject => 'Welcome to Piousbox.com' )
  end

end
