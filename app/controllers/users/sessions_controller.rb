
class Users::SessionsController < Devise::SessionsController

  layout 'application_mini'

  skip_authorization_check

  def new
    #    render :layout => @layout
  end

end
