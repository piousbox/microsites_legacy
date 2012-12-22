
require 'spec_helper'

describe ReportsController do
  
  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    User.all.each { |c| c.remove }
    
    @user = FactoryGirl.create :user
    
    @city = FactoryGirl.create :rio
    
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save
    
    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save

    sign_in @user

  end

  describe 'search' do
    it 'should work' do
      get :search, :my => true, :keyword => 'blah'
      rs = assigns(:reports)
      rs.should_not eql nil
      rs.each do |r|
        flag = r.name.include?('blah')
        flag.should eql true
      end
      
    end

  end

  describe 'index' do

    it 'displays json index of reports, with usernames' do
      get :index, :format => :json
      response.should be_success
      body = JSON.parse(response.body)
      body.length.should > 1
      body[0]['username'].should eql 'simple'
    end
    
    it 'displays my reports' do
      get :index, :my => true
      response.should be_success

      rs = assigns(:reports)
      rs.each do |r|
        r.user.should eql @user
      end
    end

    it 'scopes by city' do
      
      get :index, :cityname => 'rio', :format => :json
      response.should be_success
      
      parsed_body = JSON.parse(response.body)

      assert parsed_body.length > 1
      parsed_body.each do |report|
        report['city_id'].should eq( @city._id.to_s )
        
      end

    end

  end

end


