

class Utils::UtilsController < ApplicationController

  def old_routes
    render 'utils/old_routes'
  end

  def version
    render 'utils/version'
  end

end

