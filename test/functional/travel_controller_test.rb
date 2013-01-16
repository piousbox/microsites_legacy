
require 'test_helper'

class TravelControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'piousbox.com'

    setup_photos
    setup_cities
    setup_users
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
    assert_not_nil assigns :feature_tags
    
  end

  test 'only n_features on homepage' do
    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :site_piousbox

    (0..6).each do |i|
      f = Feature.new
      f.name = "Feature name #{i}"
    
      @site.features << f
    end
    
    assert @site.features.length > Feature.n_features
    get :home
    fs = assigns( :features )
    assert_equal Feature.n_features, fs.to_a.length
    
  end
  
end