require 'test_helper'
class ReportsControllerTest < ActionController::TestCase
  setup do
    setup_sites
    @site = FactoryGirl.create :site_pi
    @site_pt = FactoryGirl.create :site_pt
    
    Tag.clear
    @travel = FactoryGirl.create :tag_pi
    @tag = FactoryGirl.create :tag_old
    @tag_local = FactoryGirl.create :tag_local
    
    User.clear
    @user = FactoryGirl.create :user
    @manager = FactoryGirl.create :manager

    Report.all.each { |r| r.remove }
    @r = FactoryGirl.create :r1
    @r2 = FactoryGirl.create :r2
    @r3 = FactoryGirl.create :r3
    @r11 = FactoryGirl.create :r11

    @r_pt_1 = FactoryGirl.create :r_pt_1
    @r_pt_2 = FactoryGirl.create :r_pt_2
    @r_pt_3 = FactoryGirl.create :r_pt_3

    sign_in :user, @user
    
    @r.tag = Tag.new
    @r.tag.name_seo = 'cac'
    @r.tag.name = 'Cac'
    @r.tag.save
    @r.save

    @site2 = Site.where( :domain => 'test.host', :lang => 'en' ).first
    Report.all.each do |report|
      report.site = @site2
      report.save
    end
  end
  
  test 'get index' do
    @request.host = 'piousbox.com'
    site = Site.where( :domain => 'piousbox.com', :lang => 'en' ).first
    Report.all.each do |report|
      report.site = site
      report.save
    end
    get :index
    assert_response :success    
    rs = assigns(:reports)
    assert_not_nil rs
    assert rs.length < Report.paginates_per
    assert rs.length > 1
  end
  
  test 'get new' do
    sign_in :user, @user
    get :new
    assert_response :success
    assert_template :new
    assert_not_nil assigns(:report)
  end
  
  test 'no dot in name_seo' do
    report = {}
    report[:name] = 'blahssss.blah'
    report[:user_id] = @user.id
    report[:username] = @user.username
    report[:descr] = 'some descr'
    
    assert_equal 0, Report.where( :descr => report[:descr] ).length
    
    post :create, :report => report

    assert_equal 1, Report.where( :descr => report[:descr] ).length
    result = Report.where( :descr => report[:descr] ).first
    assert_equal 'blahssss-blah', result[:name_seo]
  end

  test 'redirect for username' do
    @r.tag.name_seo = @r.user.username
    assert @r.tag.save
    assert @r.save
    assert_equal @r.tag.name_seo, @r.user.username
    get :show, :name_seo => @r.name_seo
    assert_response :redirect
  end
  
  test 'get show' do
    assert_not_nil @r2.name_seo
    get :show, :name_seo => @r2.name_seo, :layout => 'application'
    assert_response :success
    assert_template :show
    assert_select '.reports-show'
  end
  
  test 'get index pt' do
    Report.all.each do |report|
      report.lang = 'pt'
      report.descr = 'texto'
      report.site = Site.where( :domain => 'test.host', :lang => 'pt' ).first
      assert_not_nil report.site
      assert report.save
    end
    
    get :index, :locale => 'pt'
    assert_response :success
    
    assert_equal 'pt', assigns(:locale)
    
    rs = assigns :reports
    assert_not_nil rs
    rs.each do |r|
      assert_equal 'pt', r.lang
    end

    assert_equal 'texto', rs[0].descr, "Brasilian report index should show some reports"
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
    r.name_seo = r.name.to_simple_string
    r.user = User.first
    r.username = User.first.username
    r.descr = 'yui'
    
    assert r.save
    
    get :show, :name_seo => r.name_seo
    assert_response :success
    assert_template 'show'
  end

  test 'cannot view private report' do
    sign_out :user

    Report.each { |r| r.remove }
    r1 = Report.create :user => User.first, :name => 'Baaa', :name_seo => 'o0fsdgefgs', :descr => 'blah blah.', :is_public => false
    r1.is_public = false
    assert r1.save
    assert_not_nil r1.name_seo

    get :show, :name_seo => r1.name_seo

    assert_response :redirect
    assert_redirected_to '/en/users/sign_in'
  end
  
end
