
require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  setup do
    @controller = WelcomeController.new

    Site.all.each { |s| s.remove }
    @site1 = FactoryGirl.create :sedux_site
    @site = FactoryGirl.create :test_site
    
    setup_users
    # @user
    # @piousbox

    setup_cities
    
    Report.all.each { |r| r.remove }
    @feature_1 = FactoryGirl.create :report
    FactoryGirl.create :feature_1
    FactoryGirl.create :feature_2
    FactoryGirl.create :feature_3

    @request.host = 'piousbox.com'
    @request.env['HTTP_REFERER'] = 'http://piousbox.com/travel'
  end

  test 'set city' do
    sign_in :user, @user
    get :home
    assert_nil cookies[:current_city]
    assert_not_nil assigns(:list_citynames)
    post :set_city, :user => { :cityname => 'New_York_City' }
    assert_response :redirect
    # assert_equal 'New_York_City', assigns(:current_user).current_city.cityname
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

  test 'help' do
    get :help
    assert_response :success
  end

  test 'check display ads toggle' do
    get :home
    assert_assigns :display_ads
  end
  
end