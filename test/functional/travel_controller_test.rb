
require 'test_helper'

class TravelControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'cac.local'
   
  end
  
  test 'get home' do
    get :home
    assert_response :redirect
    assert_redirected_to :controller => :cities, :action => :index
    
    
  end
  
  test 'get about' do
    get :about
    assert_response :success
    assert_template :about
    assert_template :travel
  end

  
end