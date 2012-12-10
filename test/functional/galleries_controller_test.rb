require 'test_helper'

class GalleriesControllerTest < ActionController::TestCase

  setup do
  
		sign_in :user, @admin
  end
  
  test 'index' do
    get :index
    assert_response :success
  end
  
  test 'get new' do
    get :new
    assert_response :success
    assert_template :new
    
  end
end