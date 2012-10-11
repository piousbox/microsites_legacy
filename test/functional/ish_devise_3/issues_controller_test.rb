require 'test_helper'

class IssuesControllerTest < ActionController::TestCase
  setup do
    @issue = issues(:one)
		@admin = users(:admin)

		sign_in :user, @admin
  end

  test "should get index" do
    
    get :index
    
    assert_response :success
    assert_not_nil assigns(:issues)
  end

  test "should show issue" do
    
    get :show, :id => @issue.to_param
    
    assert_response :success
  end

end
