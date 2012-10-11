

require 'test_helper'

class My::VideosControllerTest < ActionController::TestCase
  
  setup do
    @user = users :user
    @admin = users :admin
    
    sign_in :user, @admin
  end

  test "should get index" do
   
    get :index
    assert_response :success
    videos = assigns(:videos)
    assert_not_nil videos
    
    videos.each do |v|
      assert_equal @admin[:id], v.no_user[:id]
    end
  end
  
  test 'no_videos instead of videos' do
    
    v = NoVideo.first
    
    get :edit, :id => v.id
    
    assert_response :success
    assert_template :edit
    
  end

end
