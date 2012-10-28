
require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  
  setup do
    
    clear_reports
    clear_tags
    
    @r2 = FactoryGirl.create :r2
    @r3 = FactoryGirl.create :r3
    @r11 = FactoryGirl.create :r11
  end
  
  
  
  test 'get index' do
    get :index
    assert_response :success
    
    rs = assigns(:reports)
    assert_not_nil rs
    
    assert rs.length < 10
    assert rs.length > 1
  end
  
  test 'get new' do
    get :new
    assert_response :success
    assert_template :new
    assert_not_nil assigns(:report)
  end
  
#  test 'no dot in name_seo' do
#    report = {}
#    report[:name] = 'blah.blah'
#    report[:user_id] = 5
#    report[:descr] = 'some descr'
#    
#    
#    post :create, :report => report
#    assert_response :redirect
#    
#    result = Report.find_by_descr report[:descr]
#    assert_equal 'blah_blah', result[:name_seo]
#    
#  end
  
  test 'get show' do
    get :show, :name_seo => @r2.name_seo
    assert_response :success
    assert_template :show
  end
  
#  test 'get index pt' do
#    @request.host = 'pt.ish.com:3000'
#    get :homepage
#    assert_response :success
#    
#    assert_equal 'pt', assigns(:parsed_locale)
#    
#    rs = assigns :reports
#    assert_not_nil rs
#    assert_equal 'texto', rs[0].descr
#    
#  end
#
#  test 'get show pt' do
#    @request.host = 'pt.ish.com:3000'
#    get :show, :name_seo => 'ola'
#    assert_response :success
#    
#    r = assigns :report
#    assert_not_nil r
#    assert_equal 'texto', r.descr
#    
#  end

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
  
  
   
#  
#  test '.main_menu' do
#    get :menu_main
#    assert_response :success
#    assert_select 'ul.sf-menu li'
#  end
#  
#  test '.search_google' do
#    get :search_google, :search_keywords => 'blah and another keyword'
#    assert_response :redirect
#  end
#  
#  test "json of index" do
#    get :index, :format => :json
#    result = @response.body
#    assert_not_nil result
#    json = (JSON.parse result)[0]
#    json.each_with_index do |e, i|
#      assert_not_nil e
#    end
#  end
#  
#  test "should get index" do
#    get :index
#    assert_response :success
#    result = assigns(:reports)
#    assert_not_nil result
#    
#    msg = 'Only public reports should be in index, report id '
#		result.each do |r|
#			assert_equal 1, r[:is_public], msg + r.id.to_s
#		end
#  end
#  
#  test "should set x, y and city id" do
#    post :create, :report => { :name => 'unique name' , 
#      :descr => 'non-blank', :x => 123.444444, :y => 5559595.444,
#      :city_id => 567
#    }
#    
#    result = Report.find_by_city_id(567)
#    assert_equal 123.444444, result[:x]
#  end
#  
#  test 'homepage' do
#    get :homepage
#    assert_response :success
#    
#    reports = assigns :reports
#    assert_not_nil reports
#    
#    tags = assigns :tags
#    assert_not_nil tags
#    assert tags[0].is_a? Tag
#    assert tags.length > 1
#    
#    galleries = assigns :feature_galleries
#    assert_not_nil galleries
#    assert galleries[0].is_a? Gallery
#    
##    vs = assigns :videos
##    assert_not_nil vs
##    assert_equal 'Video', vs[0].class.name
#    
#  end
#  
#  test 'feature tags have only 4 reports' do
#    get :homepage
#    tags = assigns :feature_tags
#    
#    tags.each do |tag|
#      assert tag.feature_reports.length < 5
#    end
#    
#  end
#
#  test "should show report" do
#    get :show, :name_seo => @report[:name_seo]
#    assert_response :success
#    assert_select 'div#disqus_thread'
#  end
#
#	test "should set user_id upon create" do
#		report = { :name => 'asdffq3rf123',
#      :descr => 'descr non-empty',
#      :city_id => 5 
#    }
#
#    assert_difference('Report.count') do
#      post :create, :report => report
#    end
#    
#    #		assert_redirected_to report_path(assigns(:report))
#		# check user id
#		result = Report.find_by_name report[:name]
#		assert_equal @user.id, result[:user_id], 'user_id must be saved upon create'
#	end
#
#	test "should have tags and recommended reports on report/show" do
#		get :show, :name_seo => 'MyString2aihgfd'
#		report = assigns :report
#		assert_not_nil report
#		assert_not_nil report.tags
#    
#		recommended = (assigns :report)[:recommended]
#		assert_not_nil recommended
#		assert recommended.length <= 4
#		assert_not_nil recommended[0][:name]
#
#	end
  
end
