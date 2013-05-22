
class Users::SessionsController < Devise::SessionsController

  skip_authorization_check
  skip_before_filter :verify_authenticity_token
  
  before_filter :redirect_mobile_user, :only => [ :new ]

  respond_to :mobile, :tablet, :html

  # layout 'application_mini'
  # layout 'organizer'

end
