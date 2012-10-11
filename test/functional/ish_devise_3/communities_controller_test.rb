require 'test_helper'

class CommunitiesControllerTest < ActionController::TestCase
  setup do
    @community = communities(:one)
    @c = @community
    @admin = users(:admin)
    @user = users(:user)
  end
  
  test 'communities events' do
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

  test 'communities/users' do
    get :users, :name_seo => @c[:name_seo]
    assert_response :success
    assert_template :users
    
#    assert_not_nil assigns(:users)
#    assert_not_nil assigns(:community)
#    assert_not_nil assigns(:city)
  end
  
  test ".index_small" do
    get :index_small
    assert_response :success
    assert_not_nil assigns :communities
  end
  
  test "should get index" do
    get :index
    assert_response :success
    c = assigns(:communities)
    assert_not_nil c
    assert c[0].is_a? Community
  end

  test "should show community" do
    sign_in :user, @admin
    
    assert_not_nil @community[:name_seo]
    get :show, :name_seo => @community[:name_seo]
    assert_response :success
  end

  
end
