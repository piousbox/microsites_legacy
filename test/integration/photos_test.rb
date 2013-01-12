
require 'test_helper'

class PhotosTest < ActionDispatch::IntegrationTest

  fixtures :all

  test 'new profile photo' do
    host! 'organizer.annesque.com'

    get '/photos/new_profile_photo'
    assert_response :success
    assert_template :new_profile_photo
    assert assigns(:is_profile)
    
  end

end


