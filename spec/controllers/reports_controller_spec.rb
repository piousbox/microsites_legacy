require 'spec_helper'
describe ReportsController do
  before :each do
    Tag.all.each { |c| c.remove }
    
    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user
    @anon = FactoryGirl.create :anon

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

    setup_sites
    @site = Site.where( :domain => 'test.host', :lang => 'en' ).first

    Report.all.each do |report|
      report.site = @site
      report.save
    end

  end

  describe 'new/create' do
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
      session[:current_user] = nil
      n_old = Report.all.length
      report = { :name => '24twebfvsdfg', :name_seo => '1235fff', :descr => 'lssfllll' }
      post :create, :report => report
      n_new = Report.all.length
      ( n_new - n_old ).should eql 1
    end

    it 'adds newsitem if a new public report is created in the city' do
      assert_equal 0, @city.newsitems.all.length
      post :create, :report => { :city_id => @city.id, :is_public => true, :name => 'bhal bbgf' }
      assert_equal 1, City.find( @city.id ).newsitems.all.length
    end

    it 'adds newsitem to homepage, upon create' do
      old_n_newsitems = @site.newsitems.all.length
      post :create, :report => { :is_public => true, :name => 'bhal bbgf' }
      # and non-public
      post :create, :report => { :is_public => false, :name => 'bhal bbgfasdf s' }
      new_n_newsitems = Site.find( @site.id ).newsitems.all.length
      ( new_n_newsitems - 1 ).should eql old_n_newsitems
    end

    it 'lets you mark the report in a tag' do
      get :new
      assigns(:tags_list).should_not eql nil
    end
    it 'should create newsitems for venues' do
      vs = Venue.all.to_a
      vs.length.should_not eql 0
      venue_ids = []
      vs.each do |v|
        venue_ids << v.id
      end
      post :create, :report => { :name => 'Test Name', :descr => 'blah blah blah', :venue_ids => venue_ids, :is_public => true, 
        :user => User.all.first, :username => 'username' }
      result = Report.where( :name => 'Test Name' ).first
      venues = Venue.all
      venues.each_with_index do |venue, idx|
        ( venue.newsitems.length - 1 ).should eql vs[idx].newsitems.length
      end
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
      if 'username' != body[0]['username']
        body[0]['username'].should eql 'anon'
      end
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

    it "shows reports for the site only" do
      get :index
      response.should be_success
      assigns(:reports).each do |report|
        report.site.should_not eql nil
        report.site.domain.should eql @request.host
      end
    end
  end

  describe 'show' do
#    it 'does not show cities layout' do
#      get :show, :name_seo => @r1.name_seo, :layout => 'cities'
#      response.should render_template('layouts/application')
#    end

    it 'renders layouts application' do
      get :show, :name_seo => @r1.name_seo, :layout => 'application'
      response.should render_template('layouts/application')
    end

    it 'renders layouts application_mini' do
      get :show, :name_seo => @r1.name_seo, :layout => 'application_mini'
      response.should render_template('layouts/application')
    end

    it 'defaults to layout application_mini' do
      get :show, :name_seo => @r1.name_seo
      response.should render_template('layouts/application_mini')
    end
  end

  describe 'venues for the map' do
    it 'GETs the json of venues for the map' do
      get :venues, :name_seo => @r1.name_seo, :format => :json
      response.should be_success
      
    end
  end

end


