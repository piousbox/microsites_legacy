
require 'spec_helper'

describe WelcomeController do

  before :each do
    City.all.each { |u| u.remove }
    @sf = FactoryGirl.create :sf
    @sf.profile_photo = Photo.new
    @sf.save
    @rio = FactoryGirl.create :rio
    @rio.profile_photo = Photo.new
    @rio.save

    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user
    @simple = FactoryGirl.create :simple
    @feature_user = FactoryGirl.create :feature_user

    Report.all.each { |r| r.remove }
    @feature_pt_1 = FactoryGirl.create :feature_pt_1
    @feature_ru_1 = FactoryGirl.create :feature_ru_1
    @report_feature_1 = FactoryGirl.create :feature_1
    @report_feature_2 = FactoryGirl.create :feature_2
    @report_feature_3 = FactoryGirl.create :feature_3
    @report_feature_4 = FactoryGirl.create :feature_4

    Gallery.all.each { |g| g.remove }
    @gallery = FactoryGirl.create :gallery
    @gallery.photos << Photo.new
    @gallery.photos << Photo.new
    @gallery.photos << Photo.new
    @gallery.is_feature = true
    @gallery.save

    @request.host = 'piousbox.com'

    Site.each { |s| s.remove }
    @site = FactoryGirl.create :sedux_site
  end

  describe 'home' do
    it 'shows up' do
      get :home
      response.should be_success
      response.should render_template('welcome/home')
    end

    it 'sets locale' do
      get :home
      assigns(:locale).should_not be nil
    end

    it 'shows features, newsitems' do
      get :home
      assigns(:features).should_not eql nil
      assigns(:newsitems).should_not eql nil
    end

    it 'can show a video newsitem' do
      post :create, :video => @video
      get :home
      response.should have_tag(".Nvideo")
    end

    it 'shows feature cities' do
      get :home
      cities = assigns(:feature_cities)
      cities.should_not eql nil
      cities.to_a.length.should <= City.n_features
    end
  end

end
