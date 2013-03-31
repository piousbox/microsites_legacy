
class SitesController < ApplicationController

  skip_authorization_check

  def features
    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse # .page( params[:features_page] )
    render :layout => @layout
  end

end
