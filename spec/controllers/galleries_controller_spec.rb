require 'spec_helper'
describe GalleriesController do
  before :each do
    Photo.all.each { |ph| ph.remove }

    Report.all.each { |c| c.remove }
    
    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user
    @piousbox = FactoryGirl.create :piousbox

    Gallery.all.each { |g| g.remove }
    @g = @gallery = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2

    photos = Photo.all[0...4]
    photos.each do |photo|
      photo.gallery = @g
      photo.save
    end

    @ph1 = Photo.create :user => @user, :name => 'ph1'
    @ph2 = Photo.create :user => @user, :name => 'ph2'
    @ph3 = Photo.create :user => @user, :name => 'ph3'

    setup_sites
    @request.host = 'piousbox.com'
    @request.env['HTTP_REFERRER'] = 'http://piousbox.com'
    request.env['HTTP_REFERRER'] = 'http://piousbox.com'
  end

  describe 'not found' do
    it 'should display gallery-not-found' do
      Gallery.where( :galleryname => 'g' ).each { |g| g.remove }
      get :show, :galleryname => 'g', :locale => :en
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
      get :show, :id => @g.id, :locale => :en
      response.should be_redirect
      response.should redirect_to(gallery_path(@g.galleryname, 0))
      
      get :show, :galleryname => @g.galleryname, :locale => :en
      response.should be_success
    end

    it 'GETs show' do
      Photo.all.length.should >= 2
      Photo.all.each do |ph|
        @g.photos << ph
      end
      @g.save
      @g.photos.length.should >= 2
      get :show, :galleryname => @g.galleryname, :locale => :en
      response.should be_success
      response.should render_template('galleries/show')
      assigns(:related_galleries).should_not eql nil
    end

    it 'shows long' do
      @photo = Photo.new
      @g.photos << FactoryGirl.create( :photo )
      @g.save
      new_g = Gallery.find( @g.id )
      new_g.photos.length.should eql 1
      get :show, :galleryname => @g.galleryname, :style => 'show_long', :locale => :en
      response.should render_template('show_long')
    end

    it 'shows photo' do
      @g.galleryname.should_not eql nil
      @g.photos << FactoryGirl.create( :photo )
      @g.save
      get :show, :galleryname => @g.galleryname, :locale => :en
      response.should render_template('show')
      assigns( :photos ).should_not eql nil
    end

    it 'does not display cities layout' do
      get :show, :galleryname => @g.galleryname, :layout => 'cities', :locale => :en
      response.should render_template('layouts/application')
    end

    it 'shows only non-trash photos' do
      get :show, :galleryname => @g.galleryname, :locale => :en
      assigns(:photos).each do |photo|
        photo.is_trash.should eql false
      end
    end

    it 'redirects to first image if index of photo is out of bounds' do
      @g.photos << FactoryGirl.create( :photo )
      @g.save
      get :show, :galleryname => @g.galleryname, :photo_idx => 100
      response.should be_redirect
      response.should redirect_to("/en/galleries/show/#{@g.galleryname}/0")
    end

    it 'GETs showo for json' do
      get :show, :galleryname => @g.galleryname, :format => :json
      response.should be_success
    end

    it '#j_show' do
      get :j_show, :id => @g.id, :format => :json
      response.should be_success
    end

    it '#no_photos' do
      @gallery.photos.each { |p| p.remove }
      get :show, :galleryname => @g.galleryname, :photo_idx => 0
      response.should be_success
      response.should render_template( 'galleries/no_photos' )
    end

  end

  describe 'set show style' do
    it 'does' do
      sign_out :user
      post :set_show_style
      response.should be_redirect
      # get :show, :galleryname => @g.galleryname, :locale => :en
      # response.should render_template('show')
    end
  end
  
  describe 'index' do
    it 'gets galleries, created_at order' do
      get :index, :format => :json, :domainname => 'pi.local'
      response.should be_success
      
      gs = assigns(:galleries)
      gs.should_not be nil
      gs.each do |g|
        g.is_public.should eql true
        g.username.should_not eql nil
      end
    end

    it "only shows galleries of this site" do
      site = Site.where( :domain => 'piousbox.com', :lang => 'en' ).first
      get :index
      response.should be_redirect
      get :index, :domainname => site.domain
      assigns(:galleries).should_not eql nil
      assigns( :galleries ).each do |g|
        g.site.domain.should eql site.domain
        g.site.lang.should eql site.lang
      end
    end
  end

  describe 'create, edit, update' do
    before :each do
      setup_sites
    end

    it 'GETs new' do
      sign_in :user, @user
      get :new
      response.should be_success
      response.should render_template( 'galleries/new' )
      assigns( :cities_list ).should_not eql nil
      assigns( :cities_list ).length.should >= 1
    end

    it 'creates newsitem for site' do
      # @request.host = 'pi.local'
      
      sign_in :user, @user
      
      old_n_newsitems = Site.where( :lang => 'en', :domain => 'piousbox.com' ).first.newsitems.all.length

      g = { :is_public => true, :name => 'Name', :galleryname => 'galleryname', :user => User.all.first }
      post :create, :gallery => g

      # non-public, should not increment newsitem count
      g = { :is_public => false, :name => 'Name1', :galleryname => 'galleryname1', :user => User.all.first }
      post :create, :gallery => g

      new_n_newsitems = Site.where( :lang => 'en', :domain => 'piousbox.com' ).first.newsitems.all.length
      ( new_n_newsitems - 1 ).should eql old_n_newsitems
    end

    it 'GETs edit' do
      sign_in :user, @gallery.user
      get :edit, :id => @gallery.id
      response.should render_template( 'galleries/edit' )
      assigns( :cities_list ).should_not eql nil
    end

    it 'PUTs update' do
      sign_in :user, @user
      @gallery.user.should eql @user
      post :update, :id => @gallery.id, :gallery => @gallery.attributes
      response.should be_redirect
    end
  end
  
end
