
require 'spec_helper'

describe TravelController do

  before :each do
    City.all.each { |u| u.remove }
    @sf = FactoryGirl.create :sf
    @rio = FactoryGirl.create :rio

    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user

    Report.all.each { |r| r.remove }
    @feature_pt_1 = FactoryGirl.create :feature_pt_1
    @feature_ru_1 = FactoryGirl.create :feature_ru_1
    @report_feature_1 = FactoryGirl.create :feature_1
    @report_feature_2 = FactoryGirl.create :feature_2
    @report_feature_3 = FactoryGirl.create :feature_3
    @report_feature_4 = FactoryGirl.create :feature_4

  end

  describe 'home' do

    it 'shows up' do
      get :home
      response.should render_template('home')
      assigns(:features).length.should eql 6
      ( assigns(:newsitems).length > 1 ).should eql true
    end

  end

end
