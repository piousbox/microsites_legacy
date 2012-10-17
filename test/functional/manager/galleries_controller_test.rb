
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
    alls = Photo.all
    
    get :all_photos
    assert_response :success
    phs = assigns(:photos)
    assert alls.length > phs.length
    
    assert_not_nil phs
    phs.each do |p|
      assert_equal false, p.is_trash
    end
    
  end

end
