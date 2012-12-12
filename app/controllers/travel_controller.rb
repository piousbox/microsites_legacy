

class TravelController < ApplicationController
  
  layout 'travel'

  load_and_authorize_resource
  
  def home
    redirect_to :controller => :cities, :action => :index
  end
  
  def about
    render :layout => 'cities'
  end
  
end