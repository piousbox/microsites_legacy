
require 'test_helper'

class Manager::ReportsControllerTest < ActionController::TestCase
  
  setup do
    ;
  end
  
  test 'get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end
  
  test 'get new' do
    get :new
    assert_response :success
  end
  
end
