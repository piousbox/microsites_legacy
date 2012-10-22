

class CitiesController < ApplicationController
  
  layout 'cities'
  
  def profile
    @city = City.where( :cityname => params[:cityname] ).first
    @reports = @city.reports.where( :lang => 'en' ).page( params[:reports_page] )
    
    respond_to do |t|
      
      t.html
      
      t.json do
        a = {}
        a[:x] = @city.x
        a[:y] = @city.y
        a[:calendar_frame] = @city.calendar_frame
        a[:reports] = @reports
        render :json => a
      end
      
    end
  end
  
  def index
    
    @feature_cities = City.where( :is_feature => true ).all

    feature_city_ids = @feature_cities.map { |c| c._id }
    
    @cities = City.not_in( :_id => feature_city_ids ).all
    
    render :layout => 'application'
  end
  
  
end