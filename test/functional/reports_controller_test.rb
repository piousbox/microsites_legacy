
require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  
  setup do
    
    @r2 = FactoryGirl.create :r2
    @r3 = FactoryGirl.create :r3
  end
  
  test 'get index' do
    get :index
    assert_response :success
    
    rs = assigns(:reports)
    assert_not_nil rs
    
    assert rs.length < 10
    assert rs.length > 2
  end
  
  test 'no dot in name_seo' do
    report = {}
    report[:name] = 'blah.blah'
    report[:user_id] = 5
    report[:descr] = 'some descr'
    
    
    post :create, :report => report
    assert_response :redirect
    
    result = Report.find_by_descr report[:descr]
    assert_equal 'blah_blah', result[:name_seo]
    
  end
  
  test 'get show' do
    get :show, :name_seo => @r2.name_seo
    assert_response :success
    assert_template :show
  end
  
  test 'get index pt' do
    @request.host = 'pt.ish.com:3000'
    get :homepage
    assert_response :success
    
    assert_equal 'pt', assigns(:parsed_locale)
    
    rs = assigns :reports
    assert_not_nil rs
    assert_equal 'texto', rs[0].descr
    
  end

  test 'get show pt' do
    @request.host = 'pt.ish.com:3000'
    get :show, :name_seo => 'ola'
    assert_response :success
    
    r = assigns :report
    assert_not_nil r
    assert_equal 'texto', r.descr
    
  end
  
  test 'search' do
    sign_out :user
    
    get :search, :search_keywords => 'a'
    assert_response :success
    assert_not_nil assigns :reports
  end
  
  test 'display report without city' do
    r = Report.new
    r.name = 'ertyuirtyui'
    r.name_seo = r.name
    r.user_id = 1
    r.descr = 'yui'
    
    assert r.save
    
    get :show, :name_seo => r.name_seo
    assert_response :success
    assert_template 'show'
    
  end
  
  test 'popup' do
    get :popup, :id => 1
    assert_response :success
    assert_equal 1, assigns(:report)[:id]
  end
  
end
