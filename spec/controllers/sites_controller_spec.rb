
require 'spec_helper'

describe SitesController do

  before :each do
    City.all.each { |u| u.remove }
    @city = City.create :name => 'San Francisco', :cityname => 'San_Francisco'

    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user

    Report.all.each { |r| r.remove }
    @feature_pt_1 = FactoryGirl.create :feature_pt_1
    @feature_ru_1 = FactoryGirl.create :feature_ru_1

    @request.host = 'piousbox.com'

    setup_sites
  end

  describe 'features' do
   it 'GETs features' do
     get :features
     response.should render_template( 'sites/features' )
     assigns(:features).should_not eql nil
   end
  end

end
