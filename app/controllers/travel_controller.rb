
class TravelController < ApplicationController

  before_filter :load_features, :only => [ :home ]
  
  def home
    @tag = Tag.where( :name_seo => 'travel' ).first

    @feature_reports = Report.all.where( :lang => @locale, :is_feature => true ).page( params[:features_page] )
    
    @feature_cities = City.all.where( :is_feature => true ).limit(4)
    
    @feature_galleries = Gallery.all.where( :is_feature => true ).limit( 4 )

    # @feature_users = User.all.fresh.features.limit(4)

    @feature_tags = Tag.all.fresh
    @feature_venues = Venue.all.where( :is_feature => true ).page( params[:feature_venues_page] )
    
    @features = @site.features.all.limit( Feature.n_features )
    @newsitems = @site.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] )
    
  end
  
  def about
    ;
  end
  
end

