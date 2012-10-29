

require 'spec_helper'


describe CitiesController do
  
  before :each do
    City.all.each { |u| u.remove }
    City.create :name => 'San Francisco', :cityname => 'San_Francisco'
  end
  
  describe 'profile' do
    it 'should have div galleries-index' do
      get :profile, :cityname => 'San_Francisco'
      response.should be_success
    end
    
  end
end
