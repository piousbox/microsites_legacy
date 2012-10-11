require 'test_helper'

class TagsVenuesControllerTest < ActionController::TestCase
  setup do
    @tags_venue = tags_venues(:one)
  end

#  test "should get index" do
#    get :index
#    assert_response :success
#    assert_not_nil assigns(:tags_venues)
#  end
#
#  test "should get new" do
#    get :new
#    assert_response :success
#  end
#
#  test "should create tags_venue" do
#    assert_difference('TagsVenue.count') do
#      post :create, :tags_venue => @tags_venue.attributes
#    end
#
#    assert_redirected_to tags_venue_path(assigns(:tags_venue))
#  end
#
#  test "should show tags_venue" do
#    get :show, :id => @tags_venue.to_param
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, :id => @tags_venue.to_param
#    assert_response :success
#  end
#
#  test "should update tags_venue" do
#    put :update, :id => @tags_venue.id, :tags_venue => @tags_venue.attributes
#    assert_redirected_to tags_venue_path(assigns(:tags_venue))
#  end
#
#  test "should destroy tags_venue" do
#    assert_difference('TagsVenue.count', -1) do
#      delete :destroy, :id => @tags_venue.to_param
#    end
#
#    assert_redirected_to tags_venues_path
#  end
end
