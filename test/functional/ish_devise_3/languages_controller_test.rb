
require 'test_helper'

class LanguagesControllerTest < ActionController::TestCase
  
  setup do
    @language = languages(:one)
		@admin = users(:admin)

		sign_in :user, @admin
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:languages)
  end

  
end
