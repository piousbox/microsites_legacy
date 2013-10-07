
class Utils::UtilsController < ApplicationController

  skip_authorization_check
  
  def old_routes
    render 'utils/old_routes'
  end

  def version
    render 'utils/version'
  end

end
