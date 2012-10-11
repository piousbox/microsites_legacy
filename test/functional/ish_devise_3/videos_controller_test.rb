require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  setup do
    @venue = venues(:one)
		@user_one = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    
    vs = assigns :videos
    assert_not_nil vs
  end
  

end
