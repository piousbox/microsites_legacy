
require 'test_helper'

class Manager::IssuesControllerTest < ActionController::TestCase
  setup do
    @issue = issues(:one)
		@admin = users(:admin)

		sign_in :user, @admin
  end

#  test "should get index" do
#    get :index
#    assert_response :success
#    assert_not_nil assigns(:issues)
#  end
#
#  test "should get new" do
#    get :new
#    assert_response :success
#  end
#
#  test "should create issue" do
#    assert_difference('Issue.count') do
#      post :create, :issue => @issue.attributes
#    end
#
#    assert_redirected_to issue_path(assigns(:issue))
#  end
#
#  test "should show issue" do
#    get :show, :id => @issue.to_param
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, :id => @issue.to_param
#    assert_response :success
#  end
#
#  test "should update issue" do
#    put :update, :id => @issue.to_param, :issue => @issue.attributes
#    assert_redirected_to issue_path(assigns(:issue))
#  end

end
