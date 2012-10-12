
require 'test_helper'

class ActionController::TestCase
  include Devise::TestHelpers
end

class UsersControllerTest < ActionController::TestCase
  
  setup do
    @user = FactoryGirl.create :user
    
  end
  
  test 'get organizer' do
    
    get :organizer
    assert_response :success
    assert_template :organizer
    assert_select "a.new_photo_link"
    
  end
  
  test 'get my photos' do
    get :photos
    assert_response :success
    assert_template :photos
    
    pps = assigns(:photos)
    assert pps.length < 1
    
  end

  private
  
  def login_user(user)
    sign_in :user, user
  end

  
end