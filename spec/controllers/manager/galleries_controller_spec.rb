
require 'spec_helper'

describe Manager::GalleriesController do
  
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
    
  end

  describe 'create' do
    it 'created without specifying user id' do
      n_old = Gallery.all.length
      g = { :name => 'asdfjearguyv', :galleryname => '4tcxz' }
      post :create, :gallery => g
      n_new = Gallery.all.length
      ( n_new - n_old ).should eql 1
    end
  end
  
  describe 'index' do
    it 'can be only done' do
      get :index, :done => 1
      assigns(:galleries).each do |g|
        g.is_done.should eql true
      end
    end

    it 'searches' do
      k = 'b'
      get :index, :keywords => k
      assigns(:galleries).each do |g|
        ( g.name.include? k ).should eql true
      end
    end
    
    it 'can be only not done' do
      get :index, :done => 0
      assigns(:galleries).each do |g|
        g.is_done.should eql false
      end
    end

    it 'can be trash' do
      Gallery.all[0].update_attributes :is_trash => true
      Gallery.all[1].update_attributes :is_trash => true
      
      get :index, :is_trash => 1
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
      
      get :index
      flag = false
      assigns(:galleries).each do |gallery|
        if gallery.is_public == false
          flag = true
        end
      end
      flag.should eql true
    end
  end

  describe 'show' do
    it 'should show a gallery with no images' do
      @g.photos.length.should eql 0
      get :show, :id => @g.id
      response.should be_success
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
      get :all_photos
      response.should be_success
      assigns(:photos).should_not be nil
      assigns(:photos)[0].class.name.should eql 'Photo'
    end
  end
  
  describe 'index' do
    it 'shows galleries' do 
      get :index
      response.should be_success
      
      assigns(:galleries).should_not be nil
      assigns(:galleries)[0].class.name.should eql 'Gallery'
      assigns(:galleries).each do |g|
        g.is_trash.should be false
      end
    end
  end
  
end
