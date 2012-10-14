
require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  
#  setup do
#    @report = reports(:one)
#		@report2 = reports(:two)
#		@user = users(:one)
#    @user_user = users(:user)
#    @admin = users(:admin)
#    
#    sign_in :user, @user
#  end
  
  
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
