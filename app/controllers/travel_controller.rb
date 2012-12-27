

class TravelController < ApplicationController

  load_and_authorize_resource

  include CitiesHelper
  
  def home
    @features = []
    (0..4).each do |i|
      @features[i] = { :name => "Feature #{i}", :descr => 'Lorem Ipsum...', 
        :photo_url => 'http://acb.jpg', :is_more => true
      }
    end
    sf = City.where( :cityname => 'San_Francisco' ).first
    @features[5] = { :name => 'San Francisco', :descr => 'Travel to San Francisco', 
      :photo_url => sf.profile_photo.photo.url(:small), :link_path => travel_to_path(sf.cityname)
    }

    @newsitems = []
    (0..10).each do |i|
      @newsitems[i] = { :name => "Newsitem #{i}", :descr => 'Lorem Ipsum...', :photo_url => 'http://acb.jpg' }
    end
  end
  
  def about
    ;
  end
  
end