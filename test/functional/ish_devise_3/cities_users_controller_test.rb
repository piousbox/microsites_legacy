require 'test_helper'

class CitiesUsersControllerTest < ActionController::TestCase
  setup do
    @cities_user = cities_users(:one)
    
    sign_in :user, users(:user)
  end

  test "should get index" do
    get :index
    assert_response :success
    cus = assigns(:cities_users)
    assert_not_nil cus
    assert_not_nil cus[0][:city_name]
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cities_user" do
    assert_difference('CitiesUser.count') do
      post :create, :cities_user => @cities_user.attributes
    end

    assert_redirected_to cities_user_path(assigns(:cities_user))
  end

  test "should show cities_user" do
    get :show, :id => @cities_user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cities_user.to_param
    assert_response :success
  end

  test "should update cities_user" do
    put :update, :id => @cities_user.to_param, :cities_user => @cities_user.attributes
    assert_redirected_to cities_user_path(@cities_user[:id])
  end

end
