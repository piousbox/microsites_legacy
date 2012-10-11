require 'test_helper'

class Admin::CommunitiesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end
  
  test 'get index' do
    sign_in :user, @admin
    
    get :index
    assert_response :success
    assert_template 'index'
    communities = assigns(:communities)
    assert_not_nil communities
    communities.each do |c|
      assert_equal false, c[:is_trash]
    end
  end


end
