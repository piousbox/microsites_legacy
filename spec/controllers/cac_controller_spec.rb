
require 'spec_helper'

describe CacController do

  before :each do
    City.all.each { |u| u.remove }
    @city = City.create :name => 'San Francisco', :cityname => 'San_Francisco'

    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user

    Report.all.each { |r| r.remove }
    @feature_pt_1 = FactoryGirl.create :feature_pt_1
    @feature_ru_1 = FactoryGirl.create :feature_ru_1

  end

  describe 'homepage' do
    it 'shows CAC layout' do
      get :home
      response.should render_template('cac')
    end
  end

  
  describe 'about, privacy' do
    it 'should GET those pages' do
      pages = [ :home, :about, :home, :privacy, :portfolio, :contact, :services ]
      pages.each do |p|
        get p
      end
      response.should be_success
    end
  end

end


#get 'cac/slider', :to => 'cac#slider', :as => :cac_slider
#
#get 'cac/news', :to => 'cac#news', :as => :cac_news
#get 'cac/news/:name_seo', :to => 'cac#show', :as => :cac_report
#
#get 'cac/technology', :to => 'cac#technology', :as => :cac_technology
#get 'cac/team', :to => 'cac#team', :as => :cac_team
#get 'cac/subscribe', :to => 'cac#subscribe', :as => :cac_subscribe
