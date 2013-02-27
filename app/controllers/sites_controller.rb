
class SitesController < ApplicationController

  skip_authorization_check

  def features
    @features = @site.features.page( params[:features_page] )
    render :layout => @layout
  end

end
