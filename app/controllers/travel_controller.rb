
class TravelController < ApplicationController

  include CitiesHelper

  before_filter :redirect_to_mobi, :only => [ :home ]
  
  def home
    travel = Tag.where( :name_seo => 'travel' ).first
    
    @main_feature_reports = Report.all.where( :tag => travel ).features.limit(2)
    @feature_reports = Report.all.where( :tag => travel ).features.limit(10)[2..10] || []

    @feature_cities = City.all.features.limit(4)
    
    @feature_galleries = Gallery.where( :tag => travel ).all.features.limit(8)
  end
  
  def about
    ;
  end
  
end

