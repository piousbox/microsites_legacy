
class CitiesController < ApplicationController

  skip_authorization_check
  
  def temp
    render :layout => false
  end
  
  def profile
    
    @city = City.where( :cityname => params[:cityname] ).first

    if @city.blank?
      render :not_found
    else
      @greeter = @city.guide
      
      @features = @city.features.all.where( :lang => @locale ).order_by( :created_at => :desc ).limit( 4 )
      @feature_venues = Venue.all.where( :is_feature => true, :city => @city ).page( params[:feature_venues_page] )

      @reports = Report.all.where(
        :lang => @locale,
        :city => @city
      ).order_by( :created_at => :desc ).page( params[:reports_page] )

      @newsitems = @city.newsitems.order_by( :created_at => :desc ).page( params[:newsitems_page] )
    
      respond_to do |format|
        format.html do
          layout = params[:layout]
          render :layout => 'cities'

        end
        format.json do
          render :json => @city
          
        end
      end
    end
  end
  
  def index

    @feature_cities = City.where( :is_feature => true ).order_by( :name => :asc)
    # feature_city_ids = @feature_cities.map { |c| c._id }
    # @cities = City.not_in( :_id => feature_city_ids ).order_by( :name => :asc)
    @cities = City.order_by( :name => :asc)
    
    @feature_reports = Report.all.where( :lang => @locale, :is_feature => true ).page( params[:reports_page] )
    
    respond_to do |format|
      format.html do
        render :layout => @layout
      end
      format.json do
        render :json => @cities
      end
    end
  end

  def venues
    @venues = Venue.all
    render :controller => :venues, :action => :index
  end

  def users
    @users = User.all
    render :controller => :users, :action => :index
  end

  def today
    ;
  end
  
end