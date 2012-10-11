require 'test_helper'

class DictionaryitemsControllerTest < ActionController::TestCase
  setup do
    @dictionaryitem = dictionaryitems(:one)
		@user = users(:user)
		@admin = users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dictionaryitems)
  end

  test "should get new" do
		sign_in :user, @user

    get :new
    assert_response :success
    
    assert_not_nil assigns(:tags)
  end

  test "should create dictionaryitem" do
		sign_in :user, @user
    
    attr = { :name => 'asdvc1234ewf', :descr => 'descr' }

    assert_difference('Dictionaryitem.count') do
      post :create, :dictionaryitem => attr
    end

    assert_redirected_to dictionaryitem_path(assigns(:dictionaryitem))
    
    result = Dictionaryitem.find_by_name attr[:name]
    assert_equal @user[:id], result[:user_id]
  end

  test "should show dictionaryitem" do
    get :show, :id => @dictionaryitem.to_param
    assert_response :success
  end

  test "should get edit" do
		sign_in :user, @user
		
    get :edit, :id => @dictionaryitem.to_param
    assert_response :success
    
    assert_not_nil assigns(:tags)
  end

  test "should update dictionaryitem" do
		sign_in :user, @user

    put :update, :id => @dictionaryitem.to_param, :dictionaryitem => @dictionaryitem.attributes
    assert_redirected_to dictionaryitem_path(assigns(:dictionaryitem))
  end

end
