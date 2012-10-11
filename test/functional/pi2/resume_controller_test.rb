
require 'test_helper'

class ResumeControllerTest < ActionController::TestCase
  
  
  test 'get view' do
    get :view
    assert_response :success
    assert_template :view
    
  end
  
end