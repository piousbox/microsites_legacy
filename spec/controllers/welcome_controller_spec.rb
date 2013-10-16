require 'spec_helper'
describe WelcomeController do
  render_views
  before :each do
    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user

    @request.host = 'piousbox.com'
    @request.env['HTTP_REFERER'] = 'test.host/about'

    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :site

    Gallery.all.each { |g| g.remove }
    @gallery = FactoryGirl.create :gallery

    Report.all.each { |r| r.remove }
    @report = FactoryGirl.create :report

    City.all.each { |r| r.remove }
    @city = FactoryGirl.create :sf

  end

  describe 'Welcome Guest' do
    it 'GETs homepage' do
      get :home
      response.should be_redirect
      response.should redirect_to( '/en/sites/piousbox.com.html' )
    end
  end

  it 'set current city' do
    @user.current_city = nil;
    @user.save
    @user.current_city.should eql nil
    sign_in :user, @user
    post :set_city, :user => { :city_id => @city.id }
    response.should be_redirect
    @user = User.find( @user.id )
    @user.current_city.id.should eql @city.id
    @user.current_city.should_not eql nil
  end

  it 'search' do
    q = 'aaa'
    get :search, :q => q
    response.should be_redirect
    response.should redirect_to("https://www.google.com/search?q=site:#{@site.domain}+#{q}&ie=utf-8&oe=utf-8")
  end

end






