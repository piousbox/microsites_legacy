
require 'spec_helper'

describe Manager::ReportsController do
  
  before :each do
    Tag.all.each { |c| c.remove }
    
    User.all.each { |c| c.remove }
    @user = User.all[0]
    @admin = FactoryGirl.create :admin

    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :rio

    Report.clear
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save
    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save

    Gallery.all.each { |g| g.remove }
    @g = Gallery.create :name => 'a', :galleryname => 'bb', :user => User.all[0]
    
    sign_in @admin
    
    setup_sites
    @site = Site.where( :domain => 'test.host', :lang => 'en' ).first
  end

  describe 'show' do
    it 'should show a report with no photo' do
      r = Report.where( :photo => nil ).first
      r.should_not eql nil
      get :show, :id => r.id
      response.should render_template('manager/reports/show')
      response.should be_success
    end
  end
  
  describe 'index' do
    it 'should index' do
      r = Report.all
      (r.length > 1).should eql true
     
      get :index
      response.should be_success
      assigns(:reports).should_not eql nil
    end

    it 'should not show trash in index' do
      @r2 = FactoryGirl.create :r2
      @r2.is_trash = true
      @r2.save.should eql true
      
      get :index
      assigns(:reports).each do |report|
        report.is_trash.should_not eql true
      end
    end
    
    it 'should search' do
      post :index, :report => { :city_id => @city.id }
      assigns(:reports).should_not eql nil
    end

    it 'searches' do
      k = 'b'
      get :index, :search_words => k
      assigns(:reports).each do |g|
        ( g.name.include? k ).should eql true
      end
    end
    
    it 'should display fresh' do
      
      get :index, :fresh => 1
      response.should be_success
      assigns(:reports).should_not be nil
      assigns(:reports).each do |r|
        r.is_trash.should be false
      end
      
    end

    it 'should order by created-at' do
      get :index
      assigns(:reports).each_with_index do |r, idx|
        if idx + 1 == assigns(:reports).length
          break
        else
          assigns(:reports)[idx].created_at.should be >= assigns(:reports)[idx + 1].created_at
        end
      end
    end
    
    it 'should display public' do
      
      get :index, :public => 1
      response.should be_success
      assigns(:reports).should_not eql nil
      assigns(:reports).each do |r|
        r.is_public.should be true
      end
      
    end
    
  end
  
  describe 'create' do
    it 'puts features to homepage features' do
      old_n_features = @site.features.all.length
      post :create, :report => { :is_public => true, :is_feature => true,   :name => '1 balsdfkaposfgua sd f dsf d f' }
      post :create, :report => { :is_public => false, :is_feature => true,  :name => '2 balsdfkaposfgua sd f dsf d f' }
      post :create, :report => { :is_public => false, :is_feature => false, :name => '3 balsdfkaposfgua sd f dsf d f' }
      new_n_features = Site.find( @site.id ).features.all.length
      ( new_n_features - 1 ).should eql old_n_features
    end
  end
  
end
