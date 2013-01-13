
require 'test_helper'

class PhotosTest < ActionDispatch::IntegrationTest

  setup do
    User.clear
    @user = FactoryGirl.create :user
    
  end

  test 'how to I sign in in integration tests?' do
    assert false, 'Todo'

  end

end


