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

    @request.host = 'piousbox.com'
    @request.env['HTTP_REFERER'] = 'test.host/about'

    setup_sites
    @site = Site.where( :domain => @request.host, :lang => 'en' ).first
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

  describe 'exctact layout' do
    it 'sets application layout' do
      hosts = [ 'test.host' ]
      hosts.each do |host|
        @request.host = host
        get :about
        response.should render_template('layouts/application')
      end
    end

    it 'sets mobile layout' do
      hosts = [ 'm.test.com' ]
      hosts.each do |host|
        @request.host = host
        get :about
        response.should render_template('layouts/organizer')
      end
    end
  end

  describe 'caching' do
    def test_fragment_caching_on_some_page
      user1 = create_user :first_name => "Nick"
      user2 = create_user :first_name => "Dan"
      check_fragment_caching(user1, user2) do |user|
        @request.session[:user_id] = user.id
        get :some_page
      end
    end
    
    def check_fragment_caching(user1, user2)
      Rails.cache.clear
      ActionController::Base.perform_caching = false
      yield user1
      user_1_not_cached_body = @response.body
      
      ActionController::Base.perform_caching = true
      yield user2
      
      yield user1
      assert_equal user_1_not_cached_body, @response.body
    end
  end

end
