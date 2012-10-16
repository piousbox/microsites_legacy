
require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  setup do
    @controller = WelcomeController.new
    
    setup_users
  end
  
  test 'cac' do
    hosts = [ 'cac.local', 'computationalartscorp.com' ]
    hosts.each do |h|
      @request.host = h
      get :home
      assert_response :redirect
      assert_redirected_to :controller => :cac, :action => :home
      
      @controller = CacController.new
      get :home, :locale => 'en'
      assert_response :success
      assert_template :home
      
    end
  end
  
  test 'piousbox home' do
    hosts = [ 'piousbox.local', 'piousbox.com' ]
    hosts.each do |h|
      @request.host = h
      get :home
      
      assert_response :redirect
      assert_redirected_to :controller => :users, :action => :resume, :username => 'piousbox'
      
      @controller = UsersController.new
      
      u = User.where( :username => 'piousbox' ).first
      assert_not_nil u
      assert_equal 'piousbox@gmail.com', u.email
      
      profiles = UserProfile.all
      assert profiles.length >= 3
      
      get :resume, :username => 'piousbox', :locale => 'en'
      assert_response :success
      assert_template :resume
      
    end
  end
  
  test 'blog home' do
    @request.host = 'blog.test.local'
    
    # both reports should show
    get :home, :locale => 'en'
    assert_response :redirect
    assert_redirected_to :controller => :blog, :action => :home
    
    @controller = BlogController.new
    get :home, :locale => 'en'
    assert_response :success
    assert_template :home
      
  end
  
  test 'ish' do
    hosts = [ 'ish.local', 'infiniteshelter.com' ]
    hosts.each do |h|
      @request.host = h
      get :home, :locale => 'en'
      assert_response :redirect
      assert_redirected_to :controller => :ish, :action => :home
      
      @controller = IshController.new
      get :home, :locale => 'en'
      assert_response :success
      assert_template :home
      
    end
  end
  
  test 'travel' do
    hosts = [ 'travel.local', 'travel-guide.mobi' ]
    hosts.each do |h|
      @request.host = h
      get :home, :locale => 'en'
      assert_response :redirect
      assert_redirected_to :controller => :travel, :action => :home
      
      @controller = TravelController.new
      get :home, :locale => 'en'
      assert_response :success
      assert_template :home
      
    end
  end
  
end