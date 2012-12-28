

class TravelController < ApplicationController

  load_and_authorize_resource

  include CitiesHelper
  
  def home
    #
    # features
    #
    @features = []
    
    Report.all.features.limit(2).each do |report|
      photo_url = ''
      @features << { :name => report.name, :descr => report.subhead,
        :photo_url => photo_url, :is_more => true, :link_path => report_path(report.name_seo)
      }
    end
    
    City.features.limit(4).each do |city|
      @features << { :name => city.name, :descr => "Travel to #{city.name}",
        :photo_url => city.profile_photo.photo.url(:small), :link_path => travel_to_path(city.cityname)
      }
    end



    #
    # newsitems
    #
    @newsitems = []

    Gallery.all.features.limit(10).each do |gallery|
      @newsitems << { :name => gallery.name,
        :descr => gallery.descr,
        :photo_url => gallery.photos[0].photo.url(:thumb),
        :link_path => gallery_path(gallery.galleryname)
      }
    end

  end
  
  def about
    ;
  end
  
end