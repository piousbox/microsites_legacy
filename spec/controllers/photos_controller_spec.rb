
require 'spec_helper'

describe PhotosController do

  before :each do

    Tag.all.each { |c| c.remove }

    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user
    @anon = FactoryGirl.create :anon
    @simple = FactoryGirl.create :simple
    @user_2 = FactoryGirl.create :user_2
    @manager = FactoryGirl.create :manager
    @piousbox = FactoryGirl.create :piousbox

    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :rio
    @sf = FactoryGirl.create :sf

    Report.all.each { |c| c.remove }
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save

    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save

    Gallery.all.each { |g| g.remove }
    @gallery = FactoryGirl.create :gallery
    
    sign_in :user, @user
    session[:current_user] = @user
    @request.host = 'organizer.annesque.com'
    
  end

  describe 'create' do
    it 'should save logged in' do
      n_old = Photo.all.length
      descr = '24twebfvsdfg'
      photo = { :descr => descr }
      post :create, :photo => photo
      n_new = Photo.all.length
      ( n_new - n_old ).should eql 1
      new_photo = Photo.where( :descr => descr ).first
      new_photo.class.name.should eql 'Photo'
      # new_photo.username.should eql @user.username
    end

    it 'should not save without recaptcha' do
      PhotosController.any_instance.expects(:verify_recaptcha).returns( false )
      sign_out :user
      @current_user = nil
      session[:current_user] = nil
      n_old = Photo.all.length
      photo = { :descr => '24twebfvsdfg' }
      post :create, :photo => photo
      n_new = Photo.all.length
      ( n_new - n_old ).should eql 0
    end

    it 'should save with recaptcha' do
      PhotosController.any_instance.expects(:verify_recaptcha).returns(true)
      sign_out :user
      n_old = Photo.all.length
      photo = { :descr => '24twebfvsdfg' }
      post :create, :photo => photo
      n_new = Photo.all.length
      ( n_new - n_old ).should eql 1
    end
  end
  
  describe 'to newsitem' do
    it 'adds newsitem if a new public photo is created in the city' do
      city = City.first

      assert_equal 0, city.newsitems.length
      photo = { :city_id => city.id, :is_public => true, :name => 'bhal bbgf' }
      post :create, :photo => photo, :username => @user.username
      
      assert_equal 1, City.where( :cityname => city.cityname ).first.newsitems.length

    end

    it 'is put in newsitems of creator and viewer' do
      n_user_news = @user.newsitems.length
      n_simple_news = @simple.newsitems.length
      n_user_2_news = @user_2.newsitems.length
      session[:current_user] = @user

      photo = { :descr => 'lalala', :viewer_ids => [ @simple.id, @user_2.id ], :is_public => 1, :city_id => @sf.id }
      post :create, :photo => photo, :username => @user.username, :user_id => @user.id

      ( @user.newsitems.length - n_user_news ).should eql 1
      ( @simple.newsitems.length - n_simple_news  ).should eql 1
      ( @user_2.newsitems.length - n_user_2_news  ).should eql 1
      
    end
  end

  describe 'new profile photo' do
    it 'should get new profile photo' do
      sign_in :user, @user
      get :new, :is_profile => true
      response.should be_success
    end

    it 'should post new profile photo' do
      @user.profile_photo.blank?.should eql true
      post :create, :photo => { :set_profile_photo => 'true', :name => 'aaa' }
      response.should be_redirect
      u = User.find @user.id
      u.profile_photo.name.should eql 'aaa'
    end
  end

  describe 'new photo' do
    it 'should GET new profile photo' do
      sign_in :user, @user

      get :new_profile_photo
      assert_response :success
      assert_template :new_profile_photo
      assert assigns(:is_profile)
    end

    it 'should GET new photo for a gallery for anon' do
      sign_out :user
      
      get :new, :gallery_id => @gallery.id
      assert_response :success
      assert_template :new

    end

    it 'should GET new photo for a gallery for registered user' do
      sign_in :user, @user

      get :new, :gallery_id => @gallery.id
      assert_response :success
      assert_template :new

    end
    
  end
  
end


