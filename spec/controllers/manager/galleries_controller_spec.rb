


require 'spec_helper'


describe Manager::GalleriesController do
  
  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    Gallery.all.each { |g| g.remove }
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
    
    
    @g = Gallery.create :name => 'a', :galleryname => 'bb', :user => User.all[0]
    
    sign_in @admin
    
  end
  
  describe 'index' do
    it 'can be only done' do
      get :index, :done => 1
      assigns(:galleries).each do |g|
        g.is_done.should eql true
      end
    end
    
    it 'can be only not done' do
      get :index, :done => 0
      assigns(:galleries).each do |g|
        g.is_done.should eql false
      end
    end
  end

  describe 'show' do
    it 'should show a gallery with no images' do
      @g.photos.length.should eql 0
      get :show, :galleryname => @g.galleryname
      response.should be_success
    end
  end
  
  describe 'destroy' do
    it 'should destroy' do
      
      @g.should_not be nil
      @g.is_trash.should be false
      
      delete :destroy, :id => @g.id
      flash.notice.should eql 'Success'
      
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
      
      'Gallery'.should eql assigns(:galleries)[0].class.name
      
      assigns(:galleries).each do |g|
        g.is_trash.should be false
      end
      
    end
    
  end
  
end
