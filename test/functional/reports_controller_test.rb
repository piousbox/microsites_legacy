
require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  
  setup do
    ;
  end
  
  test 'get index' do
    get :index
    assert_response :success
    
    rs = assigns(:reports)
    assert_not_nil rs
    
    assert rs.length < 10
    assert rs.length > 2
  end
  
end
