
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
    @nyc = FactoryGirl.create :nyc
    
    Report.all.each { |r| r.remove }
    @feature_1 = FactoryGirl.create :report
    FactoryGirl.create :feature_1
    FactoryGirl.create :feature_2
    FactoryGirl.create :feature_3

    @request.host = 'piousbox.com'
    @request.env['HTTP_REFERER'] = 'http://piousbox.com/travel'
  end

  test 'set city' do
    get :home
    assert_nil cookies[:current_city]
    assert_not_nil assigns(:list_citynames)
    post :set_city, :user => { :cityname => 'New_York_City' }
    assert_response :redirect
    assert_equal 'New_York_City', cookies[:current_city][:cityname]
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
  
  
  
#  test 'piousbox home' do
#    hosts = [ 'piousbox.com' ]
#    hosts.each do |h|
#      @request.host = h
#      get :home
#      assert_response :redirect
#      assert_redirected_to :controller => :users, :action => :show, :username => 'piousbox'
#    end
#  end
  
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
  
end