class CitiesController < ApplicationController
  skip_authorization_check
  def profile
    @city = City.where( :cityname => params[:cityname] ).first
    @city.name = @city['name_'+@locale.to_s]
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

      @n_reports = @reports.length
      @n_galleries = @galleries.length
      @n_users = @city.current_users.length
      @n_videos = 0
      @n_venues = @city.venues.length

      respond_to do |format|
        format.html do
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
    feature_city_ids = @feature_cities.map { |c| c._id }
    @cities = City.not_in( :_id => feature_city_ids ).order_by( :name => :asc)
    @cities = @cities.reject do |city|
      0 == city.reports.length && 0 == city.galleries.length
    end
    
    @feature_reports = Report.all.where( :lang => @locale, :is_feature => true ).page( params[:reports_page] )
    @features = []
    @feature_venues = []
    @newsitems = Newsitem.all.page( params[:newsitems_page] )
    @today = {}
    @greeter = User.new
    @galleries = []
    @report = []

    respond_to do |format|
      format.html do
        render :layout => 'cities'
      end
      format.json do
        render :json => @cities
      end
    end
  end

  def venues
    @venues = Venue.all
    @feature_cities = []
    render :controller => :venues, :action => :index
  end

  def users
    @users = User.all
    @feature_cities = []
    render :controller => :users, :action => :index
  end

  def today
    @newsitems = Newsitem.all.page( params[:newsitems_page] )
  end
  
end

