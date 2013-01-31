
require 'test_helper'

class PhotosTest < ActionDispatch::IntegrationTest

  setup do
    User.clear
    @user = FactoryGirl.create :user
    
  end

end
