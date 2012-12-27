
require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  setup do
    @controller = WelcomeController.new

    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :sedux_site
    @site = FactoryGirl.create :test_site
    
    setup_users

    City.all.each { |f| f.remove }
    @sf = FactoryGirl.create :sf
    
  end
  
  test 'cac' do
    @request.host = 'cac.local'
      
    get :home
    assert_response :redirect
    assert_redirected_to :controller => :cac, :action => :home
  end
  
  test 'cac 2' do
      
    @request.host = 'computationalartscorp.com'
    get :home
    assert_response :redirect
    assert_redirected_to :controller => :cac, :action => :home
  end
  
  test 'piousbox home' do
    hosts = [ 'pi.local', 'piousbox.com' ]
    hosts.each do |h|
      @request.host = h
      
      get :home
      
      assert_response :redirect
      assert_redirected_to :controller => :users, :action => :resume, :username => 'piousbox'
      
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
      
    end
  end
  
  test 'travel' do
    hosts = [ 'mobi.local', 'travel-guide.mobi' ]
    hosts.each do |h|
      @request.host = h      
      @controller = TravelController.new
      get :home, :locale => 'en'
      assert_response :success
      assert_template 'home'
    end
  end
  
end