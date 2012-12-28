


require 'spec_helper'


describe Manager::ReportsController do
  
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
  
  
end
