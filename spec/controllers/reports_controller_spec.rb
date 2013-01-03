
require 'spec_helper'

describe ReportsController do
  
  before :each do
    Tag.all.each { |c| c.remove }
    
    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user

    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :rio

    Report.all.each { |c| c.remove }
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save
    
    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save

    sign_in @user
  end

  describe 'new' do
    it 'does not create without recaptcha' do
      ReportsController.any_instance.expects(:verify_recaptcha).returns(false)
      sign_out :user
      session[:current_user] = nil
      n_old = Report.all.length
      report = { :name => '24twebfvsdfg', :name_seo => '1235fff', :descr => 'lssfllll' }
      post :create, :report => report
      n_new = Report.all.length
      ( n_new - n_old ).should eql 0
    end
    
    it 'created with recaptcha' do
      ReportsController.any_instance.expects(:verify_recaptcha).returns(true)
      sign_out :user
      n_old = Report.all.length
      report = { :name => '24twebfvsdfg', :name_seo => '1235fff', :descr => 'lssfllll' }
      post :create, :report => report
      n_new = Report.all.length
      ( n_new - n_old ).should eql 1
    end
  end

  describe 'to newsitem' do
    it 'adds newsitem if a new public photo is created in the city' do
      city = City.first

      assert_equal 0, city.newsitems.length
      r = { :city_id => city.id, :is_public => true, :name => 'bhal bbgf' }
      post :create, :report => r
      
      assert_equal 1, City.where( :cityname => city.cityname ).first.newsitems.length

    end

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
      body[0]['username'].should eql 'user'
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


