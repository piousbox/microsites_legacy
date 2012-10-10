
require 'test_helper'

class Manager::CitiesControllerTest < ActionController::TestCase
  
  setup do
    ;
  end
  
  test 'get index' do
    get :index
    assert_response :success
    assert_not_nil assigns( :cities )
    
  end
  
  test 'get show' do
    get :new
    assert_response :success
    assert_not_nil assigns( :city )
    
  end
  
end
