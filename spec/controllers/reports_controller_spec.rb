require 'spec_helper'
describe ReportsController do
  before :each do    
    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user
    @anon = FactoryGirl.create :anon
    sign_in :user, @user

    Report.all.each { |c| c.remove }
    @r1 = FactoryGirl.create :r1
    @r1.user = @user
    @r1.save
    @r9 = FactoryGirl.create :r9

    setup_sites
    @site = Site.first

    @request.host = 'piousbox.com'

    Report.all.each do |report|
      report.site = @site
      report.save
    end

  end

  describe 'new/create' do
    it 'does not create without recaptcha' do
      ReportsController.any_instance.expects(:verify_recaptcha).returns(false)
      # sign_out :user
      # session[:current_user] = nil
      # user must be signed in
      n_old = Report.all.length
      report = { :name => '24twebfvsdfg', :name_seo => '1235fff', :descr => 'lssfllll' }
      post :create, :report => report
      n_new = Report.all.length
      ( n_new - n_old ).should eql 0
    end
    
    it 'created with recaptcha' do
      ReportsController.any_instance.expects(:verify_recaptcha).returns(true)
      # sign_out :user
      # session[:current_user] = nil
      # the user must be signed in, currently.
      n_old = Report.all.length
      report = { :name => '24twebfvsdfg', :name_seo => '1235fff', :descr => 'lssfllll', :user => User.all.first, :username => 'Aaa' }
      post :create, :report => report
      n_new = Report.all.length
      ( n_new - n_old ).should eql 1
      response.should redirect_to( '/en/users/organizer' )
    end

    it 'adds newsitem to homepage, upon create' do
      old_n_newsitems = @site.newsitems.all.length
      post :create, :report => { :is_public => true, :name => 'bhal bbgf' }
      # and non-public
      post :create, :report => { :is_public => false, :name => 'bhal bbgfasdf s' }
      new_n_newsitems = Site.find( @site.id ).newsitems.all.length
      ( new_n_newsitems - 1 ).should eql old_n_newsitems
    end

    it 'GETs new' do
      get :new
      response.should be_success
      response.should render_template( 'reports/new' )
      # assigns( :cities ).should_not eql nil
      assigns( :tags_list ).should_not eql nil
      assigns( :sites_list ).should_not eql nil
    end

    it 'GETs edit' do
      get :edit, :id => @r1.id
      response.should render_template( 'reports/edit' )
      assigns( :sites_list ).should_not eql nil
      assigns( :tags_list ).should_not eql nil
    end

    it 'POSTs update' do
      sign_in :user, @user
      name = 'Aaaaaabbb'
      post :update, :id => @r1.id, :report => { :name => name }
      response.should be_redirect
      result = Report.find @r1.id
      result.name.should eql name
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
      get :index, :format => :json, :domainname => 'pi.local'
      body = JSON.parse(response.body)
      body.length.should > 1
      if 'username' != body[0]['username']
        body[0]['username'].should eql 'anon'
      end
    end
    
    it 'redirects to domainname-scoped index of reports' do
      get :index
      response.should be_redirect
      response.should redirect_to( :controller => 'reports', :action => 'index', :domainname => 'piousbox.com' )
    end

    it "shows reports for the site only" do
      get :index, :domainname => 'pi.local'
      response.should be_success
      assigns(:reports).each do |report|
        report.site.should_not eql nil
        report.site.domain.should eql @request.host
      end
    end
  end

  describe 'show' do
    it 'renders' do
      get :show, :name_seo => @r1.name_seo
      response.should render_template('reports/show')
    end

    it 'GETs json' do
      get :show, :name_seo => @r1.name_seo, :format => :json
      response.should be_success
    end
  end

end




