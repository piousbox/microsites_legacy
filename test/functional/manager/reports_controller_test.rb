
require 'test_helper'

class Manager::ReportsControllerTest < ActionController::TestCase
  
  setup do
    User.all.each { |u| u.remove }
    Report.all.each { |r| r.remove }
    Tag.all.each { |u| u.remove }
    
    @user = FactoryGirl.create :user
    @admin = FactoryGirl.create :admin
    @manager = FactoryGirl.create :manager
    
    @r = FactoryGirl.create :report
    @r1 = FactoryGirl.create :r1
    @r2 = FactoryGirl.create :r2
    @r3 = FactoryGirl.create :r3

    sign_in :user, @manager
  end

  test 'get reports of no-city' do
    get :index, :report => { :city_id => '' }
    rs = assigns(:reports)
    rs.each do |r|
      assert_nil r.city
    end
    
  end

  test 'show' do
    get :show, :id => Report.first.id
    assert_response :success
  end
  
end
