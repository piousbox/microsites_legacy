
require 'spec_helper'

describe GalleriesController do
  
  before :each do
    Report.all.each { |c| c.remove }

    Tag.all.each { |c| c.remove }
    @tag = FactoryGirl.create :tag
    
    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user
    @piousbox = FactoryGirl.create :piousbox

    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :rio

    Gallery.all.each { |g| g.remove }
    @g = FactoryGirl.create :gallery
    @g.city = City.all.first
    @g.save
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2

    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :test_site
    request.host = 'test.local'

    setup_sites
  end

  describe 'not found' do
    it 'should display gallery-not-found' do
      Gallery.where( :galleryname => 'g' ).each { |g| g.remove }
      get :show, :galleryname => 'g'
      response.should be_redirect
    end
  end

  describe 'search' do
    it 'should search' do
      sign_in :user, @user
      post :search, :search_keyword => 'yada'
      response.should render_template('index')
      assigns(:galleries).should_not eql nil
    end
  end

  describe 'show' do
    it 'redirects from id to galleryname path' do
      get :show, :id => @g.id
      response.should be_redirect
      response.should redirect_to(gallery_path(@g.galleryname))
      
      get :show, :galleryname => @g.galleryname
      response.should be_success
    end

    it 'shows with add-photo link' do
      get :show, :galleryname => @g.galleryname
      response.should be_success
    end

    it 'renders cities layout' do
      @g.galleryname.should_not eql nil
      @g.city.name.should_not eql nil
      get :show, :galleryname => @g.galleryname, :layout => 'cities'
      response.should be_success
      response.should render_template('layouts/cities')
    end

    it 'shows one photo' do
      get :show_photo, :galleryname => @g.galleryname, :photo_idx => 1
      response.should be_success
      response.should render_template('galleries/show_photo')
    end

    it 'shows mini' do
      cookies[:galleries_show_style] = 'show_mini'
      @g.galleryname.should_not eql nil
      get :show, :galleryname => @g.galleryname
      response.should render_template('show_mini')
    end

    it 'shows long' do
      cookies[:galleries_show_style] = 'show_long'
      @g.galleryname.should_not eql nil
      get :show, :galleryname => @g.galleryname
      response.should render_template('show_long')
      assigns( :photos ).should_not eql nil
    end

  end

  describe 'set show style' do
    it 'does' do
      sign_out :user
      cookies[:galleries_show_style] = 'garbage'
      get :show, :galleryname => @g.galleryname
      @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'
      get :set_show_style, :style => 'show_long'
      response.should be_redirect
      response.should redirect_to 'http://test.com/sessions/new'
      cookies[:galleries_show_style].should eql 'show_long'
      get :show, :galleryname => @g.galleryname
      response.should render_template('show_long')
    end
  end
  
  describe 'index' do
    it 'gets galleries, created_at order' do
      get :index, :format => :json
      response.should be_success
      
      gs = assigns(:galleries)
      gs.should_not be nil
      gs.each do |g|
        g.is_public.should eql true
        g.username.should_not eql nil
      end

    end
  end
  
end
