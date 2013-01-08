
require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'travel.local'
    
    @photo = FactoryGirl.create :photo
    
    setup_photos
    setup_cities

    @request.host = 'piousbox.com'

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
    
    feature_cities = assigns :feature_cities
    assert_not_nil feature_cities
    
  end

  
end