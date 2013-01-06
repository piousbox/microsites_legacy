
class TravelController < ApplicationController

  include CitiesHelper
  
  def home
    travel = Tag.where( :name_seo => 'travel' ).first
    
    @main_feature_reports = Report.all.where( :tag => travel ).features.limit(2)
    @feature_reports = Report.all.where( :tag => travel ).features.limit(10)[2..10] || []

    @feature_cities = City.all.features.limit(4)
    
    @feature_galleries = Gallery.where( :tag => travel ).all.features.limit(8)

    @feature_users = User.all.fresh.features.limit(4)

    @feature_tags = Tag.all.fresh.features.limit(8)

    load_features
    
  end
  
  def about
    ;
  end
  
end

