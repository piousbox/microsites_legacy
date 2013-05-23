class CitiesController < ApplicationController
  skip_authorization_check
  # caches_page :profile, :users, :venues, :index

  def profile
    @city = City.where( :cityname => params[:cityname] ).first
    if @city.blank?
      @city = City.find params[:cityname]
      if @city.blank?
        render :action => :not_found
      else
        redirect_to city_path(@city.cityname)
      end
    else
      @city.name = @city['name_'+@locale.to_s]
      @features = @city.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse[0...4]
      @newsitems = @city.newsitems.order_by( :created_at => :desc ).page( params[:newsitems_page] )
      @reports = Report.all.where(
                                  :lang => @locale,
                                  :city => @city
                                  ).order_by( :created_at => :desc ).page( params[:reports_page] )
      @galleries = []
      @greeter = @city.guide
      @today = {}
      @feature_venues = Venue.where( :city => @city, :is_feature => true )
      
      @n_reports = @reports.length
      @n_galleries = @galleries.length
      @n_users = @city.current_users.length
      @n_videos = 0
      @n_venues = @city.venues.length
      
      respond_to do |format|
        format.html do
          layout = ('organizer' == layout)? 'cities' : 'application_cities'
          render :layout => layout
        end
        format.json do
          render :json => @city
        end
      end
    end
  end
  
  def index
    respond_to do |format|
      format.html do
        sett_empties
        @feature_cities = City.where( :is_feature => true ).order_by( :name => :asc)
        feature_city_ids = @feature_cities.map { |c| c._id }
        @cities = City.not_in( :_id => feature_city_ids ).order_by( :name => :asc)
        @cities = @cities.reject do |city|
          0 == city.reports.length && 0 == city.galleries.length
        end
        
        @feature_reports = Report.all.where( :lang => @locale, :is_feature => true ).page( params[:reports_page] )
        @features = []
        @feature_venues = []
        @today = {}
        @greeter = User.new
        @galleries = []
        @report = []
        
        render :layout => 'cities'
      end
      format.json do
        @cities = City.all
        render :json => @cities
      end
    end
  end

  def venues
    @venues = Venue.all
    sett_empties
    render :controller => :venues, :action => :index
  end

  def users
    @users = User.all
    sett_empties
    render :controller => :users, :action => :index
  end

  def today
    sett_empties
    @newsitems = Newsitem.all.page( params[:newsitems_page] )
  end

  private
 
  def sett_empties
    @cities = []
    @feature_cities = []
    @newsitems = Newsitem.all.page( params[:newsitems_page] )
  end

end

