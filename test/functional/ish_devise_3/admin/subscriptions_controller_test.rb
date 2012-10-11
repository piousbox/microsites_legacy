
require 'test_helper'


class Admin::SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @admin = users(:admin)
    
    sign_in :user, @admin
  end
  
  test 'get index' do
    get :index
    assert_response :success
  end
  
end