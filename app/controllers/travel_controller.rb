
class TravelController < ApplicationController

  before_filter :load_features, :only => [ :home ]
  
  def home
    travel = Tag.where( :name_seo => 'travel' ).first
    
    @main_feature_reports = Report.all.features.limit(2)
    # becomes features

    @feature_reports = Report.all.features.limit(10)[2..10] || []
    # becomes newsitems
    
    @feature_cities = City.all.features.limit(4)
    
    @feature_galleries = Gallery.where( :tag => travel ).all.features.limit(8)

    @feature_users = User.all.fresh.features.limit(4)

    @feature_tags = Tag.all.fresh

    @features = @site.features.all.limit(4)
    @newsitems = @site.newsitems.page( params[:newsitems_page] )
    
  end
  
  def about
    ;
  end
  
end

