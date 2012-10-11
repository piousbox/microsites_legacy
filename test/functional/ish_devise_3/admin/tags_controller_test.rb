require 'test_helper'

class Admin::TagsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end
  
  test 'sanity' do
    assert true
  end

  test 'index all public tags' do
    sign_in :user, @admin
    
    get :index
    assert_response :success
    assert_not_nil assigns(:tags)
  end
  
  test 'new tag' do
    sign_in :user, @admin
    
    get :new
    assert_response :success
    assert_template 'new'
    
    assert_not_nil assigns(:parent_tags)
  end

end
