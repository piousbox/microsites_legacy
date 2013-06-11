require 'spec_helper'

describe Manager::GalleriesController do
  render_views
  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    
    User.all.each { |c| c.remove }
    @user = User.all[0]
    @admin = FactoryGirl.create :admin
    
    @city = FactoryGirl.create :rio
    
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save
    
    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save
    
    Gallery.each { |g| g.remove }
    @g = Gallery.create :name => 'a', :galleryname => 'bb', :user => User.all[0]
    @g0 = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2
    
    sign_in @admin
    setup_sites
  end

  describe 'create' do
    it 'created without specifying user id' do
      n_old = Gallery.all.length
      g = { :name => 'asdfjearguyv', :galleryname => '4tcxz' }
      post :create, :gallery => g
      n_new = Gallery.all.length
      ( n_new - n_old ).should eql 1
    end

    it 'specifies venue upon creation' do
      get :new, :locale => :en
      assigns(:venues_list).should_not eql nil

      g = { :name => 'temp', :venue_id => Venue.all.first.id }
      post :create, :gallery => g

      result = Gallery.where( :name => g[:name] ).first
      result.venue.name.should eql Venue.all.first.name
      Venue.all.first.should_not eql nil
    end
  end
  
  describe 'index' do
    it 'shows galleries' do 
      get :index, :locale => :en
      response.should be_success
      
      assigns(:galleries).should_not be nil
      assigns(:galleries)[0].class.name.should eql 'Gallery'
      assigns(:galleries).each do |g|
        g.is_trash.should be false
      end
    end
    
    it 'can be only done' do
      get :index, :done => 1, :locale => :en
      assigns(:galleries).each do |g|
        g.is_done.should eql true
      end
    end

    it 'searches' do
      k = 'b'
      get :index, :keywords => k, :locale => :en
      assigns(:galleries).each do |g|
        ( g.name.include? k ).should eql true
      end
    end
    
    it 'can be only not done' do
      get :index, :done => 0, :locale => :en
      assigns(:galleries).each do |g|
        g.is_done.should eql false
      end
    end

    it 'can be trash' do
      Gallery.all[0].update_attributes :is_trash => true
      Gallery.all[1].update_attributes :is_trash => true
      
      get :index, :is_trash => 1, :locale => :en
      assigns(:galleries).length.should >= 1
      assigns(:galleries).each do |g|
        g.is_trash.should eql true
      end
    end

    it 'shows non-public galleries in index' do
      @g = Gallery.all.first
      @g.is_public = false
      flag = @g.save
      flag.should eql true
      
      get :index, :public => '0', :locale => :en
      assigns(:galleries).each do |gallery|
        gallery.is_public.should eql false
      end
    end

    it 'responds to json' do
      get :index, :format => :json
      result = JSON.parse(response.body)
      result.should_not eql nil
      result.length.should > 2
      result.each do |r|
        r['n_photos'].should eql 0
        r['thumb_urls'].should eql []
      end
    end
  end

  describe 'show' do
    it 'should show a gallery with no images' do
      @g.photos.length.should eql 0
      get :show, :galleryname => @g.galleryname
      response.should be_success
    end

    it 'should have .ids selector' do
      login_as @admin, scope: :user
      visit manager_gallery_path(@g.galleryname)
      page.has_selector?( '.ids' ).should eql true
      page.has_xpath?('//ids').should eql true
    end

    it 'responds to json' do
      get :show, :id => @g.galleryname, :locale => :en, :format => :json
      response.should be_success
      result = JSON.parse(response.body)
      result.length.should > 1
      result['n_photos'].should eql 0
    end
  end
  
  describe 'destroy' do    
    it 'should destroy' do
      @g.should_not be nil
      @g.is_trash.should be false
      @g.class.name.should eql 'Gallery'
      
      delete :destroy, :galleryname => @g.galleryname
      
      news = Gallery.where( :galleryname => @g.galleryname )
      news.length.should be 1
      new = news[0]
      new.is_trash.should be true
    end
  end
  
  describe 'get all photos' do
    it 'shows all photos' do
      get :all_photos, :locale => :en
      response.should be_success
      assigns(:photos).should_not be nil
      assigns(:photos)[0].class.name.should eql 'Photo'
    end
  end

  describe 'edit' do
    it 'GETs' do
      get :edit, :id => Gallery.all.first.id, :locale => :en
      response.should be_success
      assigns(:venues_list).should_not eql nil
      assigns(:tags_list).should_not eql nil
      assigns(:sites_list).should_not eql nil
    end
  end

  describe 'update' do
    it 'updates via json' do
      @gallery = Gallery.first
      @gallery.is_trash.should eql false
      put :update, :id => @gallery.id, :gallery => { :is_trash => true }, :format => :json
      response.should be_success
      result = JSON.parse(response.body)
      result.should eql []
      result = Gallery.find( @gallery.id )
      result.is_trash.should eql true
    end
  end

end
