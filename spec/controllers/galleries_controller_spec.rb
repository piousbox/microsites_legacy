
require 'spec_helper'


describe GalleriesController do
  
  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    Gallery.all.each { |g| g.remove }
    
    @user = User.all[0]
    
    @city = FactoryGirl.create :rio
    
    @g = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2
    
  end
  
  describe 'index' do
    it 'gets galleries' do
      
      get :index
      response.should be_success
      
      assigns(:galleries).should_not be nil
      assigns(:galleries).each do |g|
        g.is_public.should eql 1
      end

    end
  end
end
