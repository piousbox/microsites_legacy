
require 'test_helper'

class CacControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'cac.local'
   
  end
  
  test 'get home' do
    get :home
    assert_response :success
    assert_template :home
    
  end

  test 'get news' do
    get :news
    assert_response :success
    assert_template :news
  end
  
  test 'get privacy' do
    get :privacy
    assert_response :success
    assert_template :privacy
  end
  
  test 'get ruby on rails hosting' do
    get :hosting
    assert_response :success
    assert_template :hosting
  end
  
  test 'get about' do
    get :about
    assert_response :success
    assert_template :about
    
    assert_select '.team'
    
    assert_select '.technology'
    
  end
  
  test 'get portfolio' do
    get :portfolio
    assert_response :success
    assert_template :portfolio
  end
  
  test 'get services' do
    get :services
    assert_response :success
    assert_template :services
  end
  
  test 'get contact' do
    get :contact
    assert_response :success
    assert_template :contact
  end
  
  
end