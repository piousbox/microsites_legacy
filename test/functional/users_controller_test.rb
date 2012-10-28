
require 'test_helper'

class ActionController::TestCase
  include Devise::TestHelpers
end

class UsersControllerTest < ActionController::TestCase
  
  setup do
    
    User.all.each { |u| u.remove }
    UserProfile.all.each { |p| p.remove }
    
    @user = FactoryGirl.create :user
    @piousbox = FactoryGirl.create :piousbox
    @pi_pt = FactoryGirl.create :pi_pt
    @pi_en = FactoryGirl.create :pi_en
    @pi_ru = FactoryGirl.create :pi_ru
  
    UserProfile.all.each do |p| 
      p.user = @piousbox
      p.save
    end
  
  end
  
  test 'get resume' do
    profiles = UserProfile.where( :user => @piousbox )
    assert_equal 3, profiles.length
    
    get :resume, :username => 'piousbox', :locale => 'en'
    assert_response :success
    assert_template :resume
    
    
    user = assigns(:user)
    assert_not_nil user
  end
  
  test 'get print resume' do
    get :resume, :username => 'piousbox', :print => true, :locale => 'en'
    assert_response :success
    assert_template :print
  end
  
  test 'get organizer' do
    
    sign_in :user, @user
    
    get :organizer
    assert_response :success
    assert_template :organizer
    assert_select "a.new_photo_link"
    
  end
  
  test 'get index' do
    get :index
    assert_response :success
    assert_template :index
  end
  
  

  private
  
  def login_user(user)
    sign_in :user, user
  end

  
end