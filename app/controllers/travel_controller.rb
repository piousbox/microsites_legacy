

class TravelController < ApplicationController

  load_and_authorize_resource
  
  def home
    @features = []
    (0..5).each do |i|
      @features[i] = { :name => "Feature #{i}", :descr => 'Lorem Ipsum...', :photo_url => 'http://acb.jpg' }
    end

    @newsitems = []
    (0..10).each do |i|
      @newsitems[i] = { :name => "Newsitem #{i}", :descr => 'Lorem Ipsum...', :photo_url => 'http://acb.jpg' }
    end
  end
  
  def about
    ;
  end
  
end