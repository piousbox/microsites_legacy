
class TravelController < ApplicationController

  before_filter :load_features, :only => [ :home ]
  
  def home
    @tag = Tag.where( :name_seo => 'travel' ).first

    @feature_reports = Report.all.features.where( :lang => @locale ).page( params[:features_page] )
    
    @feature_cities = City.all.where( :is_feature => true ).limit(4)
    
    @feature_galleries = Gallery.where( :tag => @tag ).all.features.limit(8)

    # @feature_users = User.all.fresh.features.limit(4)

    @feature_tags = Tag.all.fresh

    @features = @site.features.all.limit(4)
    @newsitems = @site.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] )
    
  end
  
  def about
    ;
  end
  
end

