
require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  setup do
    Site.all.each { |s| s.remove }
    @site1 = FactoryGirl.create :sedux_site
    @site0 = FactoryGirl.create :test_site
    @site = FactoryGirl.create :site_piousbox
    
    setup_users
    # @user
    # @piousbox

    setup_cities
    
    Report.all.each { |r| r.remove }
    @feature_0 = FactoryGirl.create :report
    @feature_1 = FactoryGirl.create :feature_1
    @feature_2 = FactoryGirl.create :feature_2
    @feature_3 = FactoryGirl.create :feature_3

    @request.host = 'piousbox.com'
    @request.env['HTTP_REFERER'] = 'http://piousbox.com/travel'

    setup_photos

    setup_sites

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

  test 'help' do
    get :help
    assert_response :success
  end

  test 'check display ads toggle' do
    get :home
    assert_not_nil assigns :display_ads
  end

  test 'home' do
    @sf.profile_photo = Photo.new :user => @user
    flag = @sf.save
    assert flag

    @rio.profile_photo = Photo.new :user => @user
    assert @rio.save

    @city.profile_photo = Photo.new :user => @user
    assert @city.save

    get :home
    assert_response :success

    assert_not_nil assigns :features
    assert_not_nil assigns :newsitems

  end

#  test 'only n_features on homepage' do
#    (0..6).each do |i|
#      f = Feature.new
#      f.name = "Feature name #{i}"
#      @site.features << f
#    end
#
#    assert @site.features.length > Feature.n_features
#    get :home
#    fs = assigns( :features )
#    assert_equal Feature.n_features, fs.to_a.length
#  end
  
end