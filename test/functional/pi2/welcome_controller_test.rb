
require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  test 'get homepage' do
    get :homepage
    assert_response :success
    assert_template :homepage
  end
  
  test 'redirect to ish' do
    get '/blah_blah/whatever'
    assert_response :redirect
    
  end
  
#  test 'get projects' do
#    get :projects
#    assert_response :success
#    assert_template :projects
#  end
  
  test 'get portfolio' do
    get :portfolio
    assert_response :portfolio
    assert_template :portfolio
  end
  
  test 'get technology' do
    get :technology
    assert_response :success
    assert_template :technology
  end
  
  test 'get resume' do
    get :resume
    assert_response :success
    assert_template :resume
  end
  
end