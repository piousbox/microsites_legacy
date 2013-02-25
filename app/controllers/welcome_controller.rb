
class WelcomeController < ApplicationController

  skip_authorization_check

  before_filter :load_features

  def set_city
    next_cityname = params[:user][:cityname]
    city = City.where( :cityname => next_cityname ).first
    session[:current_city] = {
      :name => city.name,
      :cityname => city.cityname
    }
    unless current_user.blank?
      current_user.current_city = city
      current_user.save
      flash[:notice] = 'Current city set.'
    else
      flash[:notice] = 'Current city set. Login to save your selection & customize other features of this website.'
    end
    redirect_to request.referrer
  end

  def home
    case @domain
    when 'organizer.local', 'organizer.annesque.com', 'qxt.local', 'annesque.com'
      redirect_to :controller => :users, :action => :organizer

    when 'piousbox.com', 'pi.local'
      # @feature_reports = Report.all.where( :lang => @locale, :is_feature => true ).page( params[:features_page] )
      @feature_cities = City.all.where( :is_feature => true ).limit( City.n_features )
      # @feature_galleries = Gallery.all.where( :is_feature => true ).limit( 4 )
      # @feature_users = User.all.features.limit(4)
      # @feature_tags = Tag.all
      # @feature_venues = Venue.all.where( :is_feature => true ).page( params[:feature_venues_page] )
      # @tag = Tag.where( :name_seo => 'travel' ).first
      
      @features = @site.features.all.order_by( :created_at => :desc ).limit( Feature.n_features )
      @newsitems = @site.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] )
      render :layout => @layout

    end
  end

  def help
    ;
  end

  def about
    ;
  end

  def privacy
    ;
  end
  
end
