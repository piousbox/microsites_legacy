class SitesController < ApplicationController
  skip_authorization_check
  caches_page :features, :show

  def features
    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse # .page( params[:features_page] )
    render :layout => @layout
  end

  def show
    @site = Site.where( :domain => params[:domainname], :lang => @locale ).first

    # @feature_reports = Report.all.where( :lang => @locale, :is_feature => true ).page( params[:features_page] )
    @feature_cities = City.all.where( :is_feature => true ).limit( City.n_features )
    # @feature_galleries = Gallery.all.where( :is_feature => true ).limit( 4 )
    # @feature_users = User.all.features.limit(4)
    @feature_tags = Tag.where( :is_trash => false, :parent_tag => nil ).order_by( :name => :desc )
    # @feature_venues = Venue.all.where( :is_feature => true ).page( params[:feature_venues_page] )
    
    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse # [0...4]
    @newsitems = @site.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] )
    
    render :layout => @layout
  end

end
