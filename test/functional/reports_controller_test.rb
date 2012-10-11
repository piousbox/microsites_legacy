
require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  
  setup do
    
    @r2 = FactoryGirl.create :r2
    @r3 = FactoryGirl.create :r3
  end
  
  test 'get index' do
    get :index
    assert_response :success
    
    rs = assigns(:reports)
    assert_not_nil rs
    
    assert rs.length < 10
    assert rs.length > 2
  end
  
  test 'get show' do
    get :show, :name_seo => @r2.name_seo
    assert_response :success
    assert_template :show
  end
  
end
