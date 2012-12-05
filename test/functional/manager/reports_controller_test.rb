
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
  end

  test 'get reports of no-city' do
    sign_in :user, @manager
    get :index, :report => { :city_id => '' }
    rs = assigns(:reports)
    rs.each do |r|
      assert_nil r.city
    end
    
  end
  
  test 'get mark_features' do
    assert_equal 2, @manager[:group_id]
    
    sign_in :user, @manager
    
    get :mark_features
    assert_response :success
    assert_template 'mark_features'
    
    reports = assigns :items
    assert_not_nil reports
    assert_not_nil reports[0].user
    assert_not_nil reports[0].user.username
   
  end
  
  test 'post mark_features' do
    sign_in :user, @manager
    
    one = Report.find(@r[:id])
    assert_equal 1, one[:is_feature]
    
    post :mark_features, :id => 1, :is_feature => 0
    
    one = Report.find(@r[:id])
    assert_equal 0, one[:is_feature]
  end


end
