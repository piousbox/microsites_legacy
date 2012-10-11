
require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  
  setup do
    @photo = photos(:one)
    @admin = users(:admin)
    @user = users(:user)

    @request.env['HTTP_REFERER'] = 'http://test.host/'
  end
  
  
  test 'get show' do
    get :show,  :name => 'about'
    assert_response :success
    assert_template :about
    
  end
  
  
  
end
