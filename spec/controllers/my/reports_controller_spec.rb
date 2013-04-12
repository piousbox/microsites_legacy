require 'spec_helper'
describe My::ReportsController do  
  before :each do
    Tag.all.each { |c| c.remove }

    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
    sign_in :user, @user

    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :rio

    Report.all.each { |c| c.remove }    
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save
    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save
    
    setup_sites
  end

  describe 'index' do
    
    it 'shows reports' do
      sign_in :user, @user
      get :index
      response.should be_success
      response.should render_template('my/reports/index')
      reports = assigns(:reports)
      reports.each do |r|
        assert_equal r.user, @user
      end
    end
  end

end
