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
      hosts = [ 'piousbox.com', 'pt.piousbox.com', 'ru.piousbox.com', 'pi.local', 'pt.pi.local', 'ru.pi.local' ]
      hosts.each do |host|
        @request.host = host
        get :about
        response.should render_template('layouts/application')
      end
    end

    it 'sets mobile layout' do
      hosts = [ 'm.piousbox.com', 'ru.m.piousbox.com', 'pt.m.piousbox.com', 'm.pi.local', 'ru.m.pi.local', 'pu.m.pi.local' ]
      hosts.each do |host|
        @request.host = host
        get :about
        response.should render_template('layouts/organizer')
      end
    end
  end
end
