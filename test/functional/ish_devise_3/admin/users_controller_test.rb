require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @admin = users(:admin)
    
    sign_in :user, @admin
  end
  
  test 'get admin dashboard' do
    
    get :dashboard
    assert_response :success
    assert_template 'dashboard'
    
    assert_select '.admin_index_public_tags'
    
    assert_contains 'Communities'
    assert_contains 'Events'
    assert_contains 'Cities'
  end
  
  test 'get index' do
    
    get :index
    assert_response :success
    assert_template 'index'
  end
  
  test 'delete users' do
    session[:current_city] = City.find(@admin[:city_id])
    
    get :index
    assert_response :success
    assert_template :index
    
    users = assigns :users
    assert users[0].is_a? User
    
    assert_contains 'delete'
    
    
  end

  test 'can destroy' do
    u = User.find(:first)
    id = u[:id]
    assert u.is_a? User
    assert_not_nil id
    
    assert_difference('User.count', -1) do
      delete :destroy, :id => id
    end
    
    assert_raises(ActiveRecord::RecordNotFound) do
      uu = User.find(id)
    end
  end
  

end
