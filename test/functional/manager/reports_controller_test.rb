
require 'test_helper'

class Manager::ReportsControllerTest < ActionController::TestCase
  
  setup do
    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
    @admin = FactoryGirl.create :admin
    @manager = FactoryGirl.create :manager
    @anon = FactoryGirl.create :anon

    Report.all.each { |r| r.remove }
    @r = FactoryGirl.create :report
    @r1 = FactoryGirl.create :r1
    @r2 = FactoryGirl.create :r2
    @r3 = FactoryGirl.create :r3

    Tag.all.each { |u| u.remove }
    @cac_tag = FactoryGirl.create :tag_cac

    sign_in :user, @manager

    setup_sites
  end

  test 'get features' do
    get :index, :is_features => true, :lang => :en
    assert_response :success
    rs = assigns :reports
    rs.each do |r|
      assert r.is_feature
    end

    get :index, :lang => :en
    rs = assigns :reports
    at_least_one_not_feature_report = false
    rs.each do |r|
      if !r.is_feature
        at_least_one_not_feature_report = true
      end
    end

    assert at_least_one_not_feature_report
  end

  test 'get dones' do
    e = Report.all.first
    e.is_done = false
    assert e.save
    
    get :index, :is_done => true, :lang => :en
    assert_response :success
    rs = assigns :reports
    rs.each do |r|
      assert r.is_done
    end

    get :index, :lang => :en
    rs = assigns :reports
    at_least_one_not_done_report = false
    rs.each do |r|
      if !r.is_done
        at_least_one_not_done_report = true
      end
    end

    assert at_least_one_not_done_report
  end

  test 'get undones' do
    get :index, :is_undone => true, :lang => :en
    assert_response :success
    rs = assigns :reports
    rs.each do |r|
      assert !r.is_done
    end

    get :index, :lang => :en
    rs = assigns :reports
    at_least_one_not_undone_report = false
    rs.each do |r|
      if r.is_done
        at_least_one_not_undone_report = true
      end
    end

    assert at_least_one_not_undone_report
  end

  test 'get edit' do
    get :edit, :id => @r1.id, :lang => :en
    assert_response :success
  end

  test 'create, sets user' do
    Report.each { |r| r.remove }
    r = { :name => 'fff blah', :descr => ';alala', :user_id => @manager.id }
    post :create, :report => r

    result = Report.where( :name => r[:name] ).first
    assert_not_nil result
    assert_equal @manager, result.user
  end

  test 'get reports of no-city' do
    get :index, :report => { :city_id => '' }, :lang => :en
    rs = assigns(:reports)
    rs.each do |r|
      assert_nil r.city
    end
    
  end

  test 'show' do
    get :show, :id => Report.first.id, :lang => :en
    assert_response :success
  end
  
end
