
require 'test_helper'

class Manager::CitiesControllerTest < ActionController::TestCase
  
  setup do
    @rio = FactoryGirl.create :rio
    
  end
  
  test 'get index' do
    get :index
    assert_response :success
    assert_not_nil assigns( :cities )
    
  end
  
  test 'get show' do
    get :show, :id => @rio._id
    assert_response :success
    assert_not_nil assigns( :city )
    
  end
  
end
