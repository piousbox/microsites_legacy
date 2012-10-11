
require 'test_helper'

class ActionController::TestCase
  include Devise::TestHelpers
end

class UsersControllerTest < ActionController::TestCase
  
  setup do
    @user = FactoryGirl.create :user
    
  end
  
#  test 'get organizer' do
#    
#    get :organizer
#    assert_response :success
#    assert_template :organizer
#    
#  end

  private
  
  def login_user(user)
    sign_in :user, user
  end

  
end