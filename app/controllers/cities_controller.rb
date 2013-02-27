
class CitiesController < ApplicationController

  skip_authorization_check
  
  def profile
    @city = City.where( :cityname => params[:cityname] ).first

    if @city.blank?
      render :not_found
    else
      
      @features = @city.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse[0...4]
      @newsitems = @city.newsitems.order_by( :created_at => :desc ).page( params[:newsitems_page] )

      @feature_venues = Venue.all.where( :is_feature => true, :city => @city ).page( params[:feature_venues_page] )

      @reports = Report.all.where(
        :lang => @locale,
        :city => @city
      ).order_by( :created_at => :desc ).page( params[:reports_page] )

      @galleries = []

      @greeter = @city.guide

      @today = {}

      respond_to do |format|
        format.html do
          if 'application' == @layout
            @application_cities = true
            render :layout => 'application_cities'
          else
            render :layout => @layout
          end
        end
        format.json do
          render :json => @city
        end
      end
    end
  end
  
  def index
    @feature_cities = City.where( :is_feature => true ).order_by( :name => :asc)
    feature_city_ids = @feature_cities.map { |c| c._id }
    @cities = City.not_in( :_id => feature_city_ids ).order_by( :name => :asc)
    @cities = @cities.reject do |city|
      0 == city.reports.length || 0 == city.galleries.length
    end
    
    @feature_reports = Report.all.where( :lang => @locale, :is_feature => true ).page( params[:reports_page] )
    
    respond_to do |format|
      format.html do
        if 'cities' == @layout
          @city = City.new
          @newsitems = @city.newsitems.page( params[:newsitems_page] )
        end
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

