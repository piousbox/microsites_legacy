
require 'test_helper'

class Manager::CommunitiesControllerTest < ActionController::TestCase
  
  setup do
    @community = communities(:one)
    @c = @community
    @admin = users(:admin)
    @user = users(:user)
  end
  
  test 'communities/:id/events' do
    get :events, :name_seo => @c[:name_seo]
    assert_response :success
    assert_template :events
    events = assigns(:events)
    
    assert_not_nil events
    events.each do |event|
      assert_equal 1, event[:is_public]
    end
    
    assert_not_nil assigns(:community)
    assert_not_nil assigns(:city)
  end

  test 'communities/:id/users' do
    get :users, :id => 5
    assert_response :success
    assert_template :users
    assert_not_nil assigns(:users)
    assert_not_nil assigns(:community)
    assert_not_nil assigns(:city)
  end
  
  test "should set user_id upon create" do
		community = {:name => 'asdfq3rf123', :city_id => 2, :language_id => 2}
		
		post :create, :community => community
		assert_response :redirect

		sign_in :user, @admin

		post :create, :community => community
		assert_redirected_to community_path(assigns(:community))
		# check user id
		result = Community.find_by_name community[:name]
		assert_equal @admin.id, result[:user_id], 'user_id must be saved upon create'
	end
  
  test ".index_small" do
    get :index_small
    assert_response :success
    assert_not_nil assigns :communities
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:communities)
  end

  test "should get new" do
    sign_in :user, @admin
    
    get :new
    assert_response :success
  end

  test "should create community" do
    sign_in :user, @admin
    
    assert_difference('Community.count') do
      post :create, :community => @community.attributes
    end

    assert_redirected_to community_path(assigns(:community))
  end

  test "should show community" do
    sign_in :user, @admin
    
    get :show, :id => @community.to_param
    assert_response :success
  end

  test "should get edit" do
    sign_in :user, @admin
    
    get :edit, :id => @community.to_param
    assert_response :success
  end

  test "should update community" do
    sign_in :user, @admin
    
    put :update, :id => @community.to_param, :community => @community.attributes
    assert_redirected_to community_path(assigns(:community))
  end

  test "should set user_id upon create" do
		community = {:name => 'asdfq3rf123', :city_id => 2, :language_id => 2}
		
		post :create, :community => community
		assert_response :redirect

		sign_in :user, @admin

		post :create, :community => community
		assert_redirected_to community_path(assigns(:community))
		# check user id
		result = Community.find_by_name community[:name]
		assert_equal @admin.id, result[:user_id], 'user_id must be saved upon create'
	end
end
