

class CitiesController < ApplicationController
  
  layout 'cities'
  
  def profile
    @city = City.where( :cityname => params[:cityname] ).first
  end
  
  def index
    @feature_cities = City.where( :is_feature => true ).all

    feature_city_ids = @feature_cities.map { |c| c._id }
    
    @cities = City.not_in( :_id => feature_city_ids ).all
  end
  
  
end