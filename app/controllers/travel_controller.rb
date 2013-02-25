
class TravelController < ApplicationController

  skip_authorization_check :only => [ :home, :about ]
  
  def home
    

    @feature_reports = Report.all.where( :lang => @locale, :is_feature => true ).page( params[:features_page] )
    @feature_cities = City.all.where( :is_feature => true ).limit(4)
    @feature_galleries = Gallery.all.where( :is_feature => true ).limit( 4 )
    # @feature_users = User.all.features.limit(4)
    @feature_tags = Tag.all
    @feature_venues = Venue.all.where( :is_feature => true ).page( params[:feature_venues_page] )
    
    
  end
  
  
  
end

