
require 'test_helper'

class ActionController::TestCase
  include Devise::TestHelpers
end

class UsersControllerTest < ActionController::TestCase
  
  setup do
    @user = FactoryGirl.create :user
    @piousbox = FactoryGirl.create :piousbox
    @pi_pt = FactoryGirl.create :pi_pt
    @pi_en = FactoryGirl.create :pi_en
    @pi_ru = FactoryGirl.create :pi_ru
    
  end
  
  test 'get resume' do
    get :resume, :username => 'test_username'
    assert_response :success
    assert_template :resume
    
    
    user = assigns(:user)
    assert_not_nil user
  end
  
  test 'get organizer' do
    
    get :organizer
    assert_response :success
    assert_template :organizer
    assert_select "a.new_photo_link"
    
  end
  
  test 'get articles' do
    assert false, 'todo'
  end
  
  test 'get reports' do
    assert false, 'todo'
  end
  
  test 'get index' do
    get :index
    assert_response :success
    assert_template :index
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