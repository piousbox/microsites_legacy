require 'spec_helper'
describe "cities", :type => :feature do

  before :each do
    setup_cities
    @city = @sf

    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user
    
    Report.all.each { |r| r.remove }
    @feature_pt_1 = FactoryGirl.create :feature_pt_1
    @feature_ru_1 = FactoryGirl.create :feature_ru_1
    @report = FactoryGirl.create :report

    Gallery.all.each { |g| g.remove }
    @gallery = FactoryGirl.create :gallery

    setup_sites
    @site = Site.all.first
    @site.domain = 'example.com'
    @site.lang = 'en'
    @site.save
  end

  it 'renders OK a city profile' do
    visit '/en/cities/travel-to/San_Francisco'
    find('.ns')['n_reports'].should eql '0'
    find('.ns')['n_galleries'].should eql '0'
    find('.ns')['n_venues'].should eql '0'
    find('.ns')['n_videos'].should eql '0'
    find('.ns')['n_users'].should eql '0'
  end

  it 'has the cityname on the canvas div in city profile' do
    visit '/en/cities/travel-to/San_Francisco'
    find('#cities_show_canvas')['cityname'].should eql 'San_Francisco'
  end

  it "has travel to and city name in the page title" do
    visit "/en/cities/travel-to/San_Francisco"
    find('head title').native.text.should have_content('San Francisco')
    find('head title').native.text.should have_content('Travel To')
  end

  it 'has a reasonable title of the index page' do
    visit '/en/cities'
    find('head title').native.text.should have_content('Travel')
  end

end
