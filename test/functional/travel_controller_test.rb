
require 'test_helper'

class TravelControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'cac.local'
   
  end
  
  test 'get home' do
    get :home
    assert_response :success
    assert_template :home
    
  end

  
end