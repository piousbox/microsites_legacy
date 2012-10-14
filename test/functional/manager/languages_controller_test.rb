
require 'test_helper'

class Manager::LanguagesControllerTest < ActionController::TestCase
  
  setup do
    @language = languages(:one)
		@admin = users(:admin)

		sign_in :user, @admin
  end

#  test "should show language" do
#    get :show, :id => @language.to_param
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, :id => @language.to_param
#    assert_response :success
#  end
#
#  test "should update language" do
#    put :update, :id => @language.to_param, :language => @language.attributes
#    assert_redirected_to language_path(assigns(:language))
#  end
#  
#  test "should create language" do
#    assert_difference('Language.count') do
#      post :create, :language => @language.attributes
#    end
#
#    assert_redirected_to language_path(assigns(:language))
#  end
end