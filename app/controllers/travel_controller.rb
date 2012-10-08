

class TravelController < ApplicationController
  
  layout 'travel'
  
  def home
    redirect_to :controller => :cities, :action => :index
  end
  
  def about
    render :layout => 'cities'
  end
  
end