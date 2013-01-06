
require 'test_helper'

class TravelControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'piousbox.com'

    setup_cities
    setup_users
  end

  test 'home' do
    @sf.profile_photo = Photo.new :user => @user
    flag = @sf.save
    assert flag
    
    @rio.profile_photo = Photo.new :user => @user
    assert @rio.save
    @city.profile_photo = Photo.new :user => @user
    assert @city.save
    
    get :home
    assert_not_nil assigns(:features)
  end
  
end