
class WelcomeController < ApplicationController
  skip_authorization_check
  before_filter :load_features

  # caches_page :homepage, :features, :newsitems
  
  def home
    redirect_to site_path( @domain )
  end


  def features
    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse # .page( params[:features_page] )
    render :layout => @layout
  end

  def newsitems
    ;
  end

end
