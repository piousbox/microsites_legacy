

class CitiesController < ApplicationController
  
  layout 'cities'
  
  load_and_authorize_resource
  
  def profile
    @city = City.where( :cityname => params[:cityname] ).first
    @reports = @city.reports.fresh.public.where( :lang => 'en' ).order_by( :created_at => :desc ).page( params[:reports_page] )
    

    respond_to do |format|
      format.html
      format.json do
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
    
    @feature_cities = City.where( :is_feature => true ).order_by( :name => :asc)
    # feature_city_ids = @feature_cities.map { |c| c._id }
    # @cities = City.not_in( :_id => feature_city_ids ).order_by( :name => :asc)
    @cities = City.order_by( :name => :asc)

    @feature_reports = Report.fresh.public.features.order_by( :created_at => :desc ).page( params[:reports_page] )
    
    respond_to do |format|
      format.html do
        render :layout => 'application'
      end
      format.json do
        render :json => @cities
      end
    end
    
  end
  
end