
require 'test_helper'

class Econ::WelcomeControllerTest < ActionController::TestCase

  setup do
    User.clear
    @user = FactoryGirl.create :user
    
  end

  test 'get home' do
    sign_in :user, @user
    get :home
    assert_response :success
    assert_template 'econ/home'
  end

end
