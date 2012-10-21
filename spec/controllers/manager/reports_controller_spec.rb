


require 'spec_helper'


describe Manager::ReportsController do
  
  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    Gallery.all.each { |g| g.remove }
    
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
    it 'should index' do
      
      r = Report.all
      (r.length > 1).should eql true
     
      get :index
      assigns(:reports).should_not eql nil
      
    end
    
    it 'shold search' do
      
      get :search, :report => { :city_id => @city.id }
      assigns(:reports).should_not eql nil
      
    end
    
    it 'should display fresh' do
      
      get :index, :fresh => 1
      assigns(:reports).should_not be nil
      assigns(:reports).each do |r|
        r.is_trash.should be false
      end
      
    end
    
    it 'should display public' do
      
      get :index, :public => 1
      assigns(:reports).should_not eql nil
      assigns(:reports).each do |r|
        r.is_public.should be true
      end
      
    end
    
  end
  
  
end
