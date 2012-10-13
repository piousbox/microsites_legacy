

class Users::SessionsController < Devise::SessionsController
  
  layout 'resume'
  
  def sign_in
    @title = 'Sign In'
    super
  end
  
end