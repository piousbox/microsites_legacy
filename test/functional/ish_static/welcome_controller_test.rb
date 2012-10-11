

require 'test_helper'
class WelcomeControllerTest < ActionController::TestCase
  
  test 'get home' do
    get :home
    assert_response :success
    assert_template :home
    
  end
  
end