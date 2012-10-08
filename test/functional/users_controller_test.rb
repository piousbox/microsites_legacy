
require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  include Devise::TestHelpers
  
  setup do
    @user = FactoryGirl.create :user
    
  end
  
  test 'get organizer' do
    get :organizer
    assert_response :redirect
    assert_redirected_to :controller => :users, :action => :sign_in
    
    sign_in :user, @user
    
    get :organizer
    assert_response :success
    
    assert_template :organizer
    
  end

  
end