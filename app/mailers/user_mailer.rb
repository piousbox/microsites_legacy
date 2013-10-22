
class UserMailer < ActionMailer::Base

  default :from => "admin@piousbox.com"

  def welcome_email(user, site = Site.new )
    @site = site
    @user = user
    @url = 'http://piousbox.com/en/users/sign_in'
    mail( :to => user.email, :subject => 'Welcome to Piousbox.com' )
  end

end
