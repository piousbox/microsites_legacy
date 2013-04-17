
class Users::SessionsController < Devise::SessionsController

  skip_authorization_check
  skip_before_filter :verify_authenticity_token

  layout 'application_mini'
  
end
