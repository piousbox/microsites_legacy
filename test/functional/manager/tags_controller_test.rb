
require 'test_helper'

class Manager::TagsControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:one)
    @admin = users(:admin)
    @manager = users :manager
    
    @tag = tags :one
    @t = { :name => '6543234rtg', :name_seo => '65uhnrtbfvd' }
    
  end
  
  test 'get index' do
    sign_in :user, @manager
    
    get :index
    
    assert_response :success
    assert_template :index
    
    tags = assigns :tags
    assert_not_nil tags
    assert tags[0].is_a? Tag
    
  end

  test "should get new" do
    sign_in :user, @admin
    
    get :new
    assert_response :success
    assert_template :new
    
  end

  test "should create tag" do
    sign_in :user, @user
    
    
    
    assert_difference('Tag.count') do
      post :create, :tag => @t
    end

    assert_redirected_to manager_tags_path
  end
  
  test "should get edit" do
    sign_in :user, @admin
    
    get :edit, :id => @tag.to_param
    assert_response :success
    assert_template :edit
    
  end

  test "should update tag" do
    sign_in :user, @admin
    
    put :update, :id => @tag.to_param, :tag => @tag.attributes
    
    assert_redirected_to manager_tags_path
  end

  test "should set user_id upon create" do
		tag = {:name => 'asdfq3rf123'}

		sign_in :user, @user

		post :create, :tag => tag
		assert_redirected_to manager_tags_path
		# check user id
		result = Tag.find_by_name tag[:name]
		assert_equal @user.id, result[:user_id], 'user_id must be saved upon create'
	end

end
