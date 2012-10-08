
require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'travel.local'
    @sf = FactoryGirl.create :sf
  end
  
  test 'get profile' do
    get :profile, :cityname => 'San_Francisco'
    assert_response :success
    assert_template :profile
    assert_template :cities
    
    city = assigns :city
    assert_not_nil city
    
  end
  
  test 'get index' do
    get :index
    assert_response :success
    assert_template :index
    assert_template :cities
    
    cities = assigns :cities
    assert_not_nil cities
    
  end

  
end