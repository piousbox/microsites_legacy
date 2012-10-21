


require 'spec_helper'


describe Manager::GalleriesController do
  
  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    
    @user = User.all[0]
    
    @city = FactoryGirl.create :rio
    
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save
    
    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save
    
    sign_in @user
    
  end
  
  describe 'destroy' do
    it "shold flag a gallery as deleted" do
      assert false, 'todo'
    end
  end
  
  describe 'get all photos' do
    it 'shows all photos' do
      assert false, 'todo'
    end
  end
  
  
  describe 'index' do
    
    it 'shows galleries' do
      
      get :index
      response.should be_success
      
      gs = assigns(:galleries)
      assert_not_nil gs
      assert_equal 'Gallery', gs[0].class.name
      
      gs.each do |g|
        assert_equal 0, g.is_trash
      end
      
    end
    
  end
  
end
