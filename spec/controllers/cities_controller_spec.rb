

require 'spec_helper'


describe CitiesController do
  
  before :each do
    City.all.each { |u| u.remove }
    City.create :name => 'San Francisco', :cityname => 'San_Francisco'
  end

  describe 'index' do
    
    it 'has reports' do
      get :index
      assigns(:feature_reports).should_not be nil
    end

    it 'can set locale' do
      get :index
      assigns(:parsed_locale).should_not be nil
      
    end
    
  end

  describe 'profile' do
    it 'should have div galleries-index' do
      get :profile, :cityname => 'San_Francisco'
      response.should be_success

      rs = assigns(:reports)
      (0..rs.length-1).each do |idx|
        rs[idx].created_at.should be >= rs[idx+1].created_at
      end
    end
    
  end
end
