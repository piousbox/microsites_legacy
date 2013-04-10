require 'spec_helper'
describe WelcomeController do
  render_views
  before :each do
    City.all.each { |u| u.remove }
    @sf = FactoryGirl.create :sf
    @sf.profile_photo = Photo.new
    @sf.save
    @rio = FactoryGirl.create :rio
    @rio.profile_photo = Photo.new
    @rio.save
    
    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user
    @simple = FactoryGirl.create :simple
    @feature_user = FactoryGirl.create :feature_user

    Report.all.each { |r| r.remove }
    @feature_pt_1 = FactoryGirl.create :feature_pt_1
    @feature_ru_1 = FactoryGirl.create :feature_ru_1
    @report_feature_1 = FactoryGirl.create :feature_1
    @report_feature_2 = FactoryGirl.create :feature_2
    @report_feature_3 = FactoryGirl.create :feature_3
    @report_feature_4 = FactoryGirl.create :feature_4

    Gallery.all.each { |g| g.remove }
    @gallery = FactoryGirl.create :gallery
    @gallery.photos << Photo.new
    @gallery.photos << Photo.new
    @gallery.photos << Photo.new
    @gallery.is_feature = true
    @gallery.save

    @request.host = 'piousbox.com'
    @request.env['HTTP_REFERER'] = 'test.host/about'

    setup_sites
    @site = Site.where( :domain => @request.host, :lang => 'en' ).first

    Video.all.each { |v| v.remove }
    @video_1 = FactoryGirl.create :v1
    @video_2 = FactoryGirl.create :v2
    @video_3 = FactoryGirl.create :v3

  end

  describe 'header' do
    it 'lets you select from only feature cities' do
      @request.host = 'piousbox.com'
      get :about
      length = assigns(:list_citynames).length
      assigns( :list_citynames )[1...length].each do |city|
        city.is_feature.should eql true
      end
      # this test is bullshit by the way
    end
  end

  describe 'help' do
    it 'GETs help' do
      get :help
      response.should be_success
      response.should render_template('welcome/help')
    end
  end

  describe 'set city' do
    it 'sets city' do
      sign_in :user, @user
      get :about
      get :help
      cookies[:current_city].should eql nil
      assigns(:list_citynames).should_not eql nil
      post :set_city, :user => { :cityname => 'New_York_City' }
      assert_response :redirect
      # assert_equal 'New_York_City', assigns(:current_user).current_city.cityname
    end
  end

end
