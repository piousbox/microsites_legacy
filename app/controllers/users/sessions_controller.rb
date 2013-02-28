
class Users::SessionsController < Devise::SessionsController
  
  skip_authorization_check

  def new
    render :layout => @layout
  end
  
end
