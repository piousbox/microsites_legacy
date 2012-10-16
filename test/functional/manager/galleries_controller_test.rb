
require 'test_helper'

class Manager::GalleriesControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:one)
    @admin = users(:admin)
    @manager = users :manager
    
    @r = reports(:one)
  end
  
  test 'get index' do
    sign_in :user, @manager
    
    get :index
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:galleries)
  end
  
  test 'get all photos' do
    get :all_photos
    assert_response :success
    assert_not_nil assigns(:photos)
  end

end
