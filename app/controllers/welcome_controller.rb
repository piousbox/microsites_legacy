
class WelcomeController < ApplicationController
  skip_authorization_check
  before_filter :load_features

  # caches_page :homepage, :features, :newsitems
  
  def home
    redirect_to site_path( @domain )
  end

end
