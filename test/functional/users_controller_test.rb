require 'test_helper'
class UsersControllerTest < ActionController::TestCase
  setup do
    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
    @piousbox = FactoryGirl.create :piousbox

    UserProfile.all.each { |p| p.remove }
    @pi_pt = FactoryGirl.create :pi_pt
    @pi_en = FactoryGirl.create :pi_en
    @pi_ru = FactoryGirl.create :pi_ru
    UserProfile.all.each do |p|
      p.user = @piousbox
      p.save
    end
    
    Gallery.clear
    @g = FactoryGirl.create :pi_gallery

    setup_sites
  end
  
  test 'get show' do
    profiles = UserProfile.where( :user => @piousbox )
    assert_equal 3, profiles.length
    
    get :show, :username => 'piousbox', :locale => 'en'
    assert_response :success
    assert_template :resume

    get :show, :username => 'piousbox'
    
    user = assigns(:user)
    assert_not_nil user

    profile = assigns(:profile)
    assert_not_nil profile
    assert_not_nil profile.education
    assert_select('.edu', profile.education)
  end
  
  test 'get print resume' do
    get :show, :username => 'piousbox', :print => true, :locale => 'en'
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

  test 'gallery' do
    get :gallery, :galleryname => @g.galleryname
    assert_response :success
    assert_template 'users/gallery'
  end

  test 'get user galleries' do
    Photo.all.each { |e| e.remove }
        url = 'http://s3.amazonaws.com/ish-assets/loginWithFacebook.png'
    new = Photo.new
    new.photo = open(url)
    new.user = User.all.first
    assert new.save

    g = Gallery.where( :user => @user ).first
    g.photos << new
    assert g.save

    get :galleries, :username => @user.username
    assert_response :success
    gs = assigns(:galleries)
    assert gs.length > 0
    gs.each do |g|
      assert_equal false, g.is_trash
      assert g.is_public
    end
  end

  private
  
  def login_user(user)
    sign_in :user, user
  end
  
end
