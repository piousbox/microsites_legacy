
require 'spec_helper'

describe TravelController do

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
  end

  describe 'home' do
    it 'shows up' do
      get :home
      response.should render_template('home')
      ( assigns(:feature_reports).length > 0 ).should eql true
    end

    it 'shows new users' do
      get :home
      users = assigns(:feature_users)
      users.should_not eql nil
      users.length.should >= 1
      users.each do |u|
        u.is_feature.should eql 1
      end
    end
  end

end
