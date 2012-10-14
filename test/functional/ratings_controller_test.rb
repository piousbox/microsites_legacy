require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end
  
  test 'rate' do
    get :rate_this
    assert_response :success
  end

end
