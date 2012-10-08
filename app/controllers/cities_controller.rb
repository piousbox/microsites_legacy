

class CitiesController < ApplicationController
  
  layout 'cities'
  
  def profile
    @city = City.where( :cityname => params[:cityname] ).first
  end
  
  def index
    @cities = City.all
  end
  
  
end