
class TravelController < ApplicationController

  include CitiesHelper

  before_filter :redirect_to_mobi, :only => [ :home ]
  
  def home
    @main_feature_reports = Report.all.features.limit(2)
    @feature_reports = Report.all.features.limit(10)[2..10] || []
    @feature_cities = City.all.features.limit(4)
    @feature_galleries = Gallery.all.features.limit(8)
  end
  
  def about
    ;
  end
  
end

