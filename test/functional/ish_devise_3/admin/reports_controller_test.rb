require 'test_helper'

class Admin::ReportsControllerTest < ActionController::TestCase
  setup do
    @user = users(:user)
    @admin = users(:admin)
    
    sign_in :user, @admin
    
    @report_1 = reports(:one)
  end
  
  test "should get homepage" do
    get :homepage
    assert_response :success
    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

	test "should get new" do
		get :new
		assert_response :success
	end

	test "should get edit" do
		get :edit, :id => 5
		assert_response :success
	end

	test "should get create" do
		assert_difference('Report.count') do
			post :create, :report => { :name => 'somename', :name_seo => 'seo', :descr => 'nonempty'}
		end
   
	end

	test "should get update" do
		put :update, :id => @report_1.id, :report => @report_1.attributes
		assert_response :redirect
		assert_redirected_to report_path(@report_1.id)
	end

end
