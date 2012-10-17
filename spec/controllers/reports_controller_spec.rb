
require 'spec_helper'


describe ReportsController do
  
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
    
  end
  
  describe 'index' do
    it 'scopes by city' do
      sign_in @user
      get :index, :cityname => 'rio', :format => :json
      response.should be_success
      
      parsed_body = JSON.parse(response.body)
      # puts! parsed_body

      assert parsed_body.length > 1
      parsed_body.each do |report|
        report['city_id'].should eq( @city._id.to_s )
        
      end
    end
  end
end
