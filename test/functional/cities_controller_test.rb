
require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'travel.local'
    Photo.all.each { |p| p.remove }
    City.all.each { |c| c.remove }

    @photo = FactoryGirl.create :photo
    
    @sf = FactoryGirl.create :sf
    @city = FactoryGirl.create :city
    @rio = FactoryGirl.create :rio

    City.all.where( :is_feature => 1 ).each do |city|
      city.profile_photo = Photo.first
      city.save
    end

  end
  
  test 'get profile' do
    get :profile, :cityname => 'San_Francisco'
    assert_response :success
    assert_template :profile
    assert_template :cities
    
    city = assigns :city
    assert_not_nil city
    
    assert_select 'a.calendar_link'

    reports = assigns :reports
    reports.each do |r|
      assert_equal r.is_trash, 0
    end

    
  end
  
  test 'json for profile' do
    get :profile, :cityname => 'rio', :format => :json
    assert_response :success
    
    city = assigns(:city)
    assert_not_nil city
    assert_equal 'calendar', city[:calendar_frame]
    
  end
  
  test 'get index' do
    get :index
    assert_response :success
    assert_template :index
    assert_template :cities
    
    cities = assigns :cities
    assert_not_nil cities
    assert_select '.cities'
    
    feature_cities = assigns :feature_cities
    assert_not_nil feature_cities
    assert_select '.feature-cities'
    
  end

  
end