require 'test_helper'

class My::TagsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end
  
  test 'sanity' do
    assert true
  end
  
  test 'my index' do
    sign_in :user, @admin
    
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:tags)
  end


end
