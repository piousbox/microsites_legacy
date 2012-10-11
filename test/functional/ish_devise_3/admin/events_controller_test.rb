require 'test_helper'

class Admin::EventsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end
  
  test 'get index' do
    sign_in :user, @admin
    
    get :index
    assert_response :success
    assert_template 'index'
    events = assigns(:events)
    assert_not_nil events
    events.each do |c|
      assert_equal false, c[:is_trash]
    end
  end


end
