
class Users::SessionsController < Devise::SessionsController

  skip_authorization_check

  caches_page :new
 
  def new
    ;
  end
  
end
