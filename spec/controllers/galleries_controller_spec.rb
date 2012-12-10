
require 'spec_helper'


describe GalleriesController do
  
  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    Gallery.all.each { |g| g.remove }
    User.all.each { |c| c.remove }
    
    @user = FactoryGirl.create :user

    @city = FactoryGirl.create :rio
    
    @g = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2
    
  end

  describe 'search' do
    it 'should search' do
      sign_in :user, @user
      post :search, :search_keyword => 'yada'
      response.should render_template('index')
      assigns(:galleries).should_not eql nil
      
    end

  end
  
  describe 'index' do
    it 'gets galleries, created_at order' do
      get :index
      response.should be_success
      
      gs = assigns(:galleries)
      (0..gs.length-1).each do |idx|
        gs[idx].created_at.should be >= gs[idx+1].created_at
      end
      gs.should_not be nil
      gs.each do |g|
        g.is_public.should eql true
      end

    end
  end
end
