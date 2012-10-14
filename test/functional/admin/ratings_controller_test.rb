require 'test_helper'

class Admin::RatingsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end
  
#  test 'ACL of index' do
#    get :index
#    assert_response :redirect
#    assert_redirected_to sign_in_path
#    
#  end
#  
#  test 'get index' do
#    sign_in :user, @admin
#    
#    get :index
#    assert_response :success
#    assert_template 'index'
#    assert_not_nil assigns(:ratings)
#  end


end
