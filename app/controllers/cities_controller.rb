

class CitiesController < ApplicationController
  
  layout 'cities'
  
  load_and_authorize_resource

  def temp
    render :layout => false
  end
  
  def profile
    @city = City.where( :cityname => params[:cityname] ).first
    @reports = Report.fresh.public.where(
      :lang => @locale,
      :city => @city
    ).order_by( :created_at => :desc ).page( params[:reports_page] )

    @newsitems = @city.newsitems.order_by( :created_at => :desc )
    
    respond_to do |format|
      format.html
      format.json do
        render :json => @city
      end
    end
  end
  
  def index
    
    @feature_cities = City.where( :is_feature => true ).order_by( :name => :asc)
    # feature_city_ids = @feature_cities.map { |c| c._id }
    # @cities = City.not_in( :_id => feature_city_ids ).order_by( :name => :asc)
    @cities = City.order_by( :name => :asc)

    @feature_reports = Report.fresh.public.where( :lang => @locale ).features.order_by( :created_at => :desc ).page( params[:reports_page] )
    
    respond_to do |format|
      format.html do
        if '1' == @is_mobile
          render :layout => 'organizer'
        else
          render :layout => 'application'
        end
      end
      format.json do
        render :json => @cities
      end
    end
  end
  
end