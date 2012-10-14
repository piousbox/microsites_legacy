
require 'test_helper'

class A5sControllerTest < ActionController::TestCase
  
  setup do
    
    @a5 = A5.create :a1 => 'blah', :a2 => 'blah blah', :date => '2012-01-01'
    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:a5s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create a5" do
    assert_difference('A5.count') do
      post :create, :a5 => @a5.attributes
    end

    assert_redirected_to a5_path(assigns(:a5))
  end

  test "should show a5" do
    get :show, id: @a5.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @a5.to_param
    assert_response :success
  end

  test "should update a5" do
    put :update, id: @a5.to_param, a5: @a5.attributes
    assert_redirected_to a5_path(assigns(:a5))
  end

  test "should destroy a5" do
    assert_difference('A5.count', -1) do
      delete :destroy, id: @a5.to_param
    end

    assert_redirected_to a5s_path
  end
  
end
