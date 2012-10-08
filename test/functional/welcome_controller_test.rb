

class WelcomeControllerTest < ActionController::TestCase
  
  setup do
    
    clear_tags
    clear_reports
    
    # order matters
    @r1 = FactoryGirl.create :r1
    @tag2 = Tag.create :name => 'Tag 2',
      :parent_tag => Tag.where(:domain => 'blog.test.local').first
    @r4 = FactoryGirl.create :r4
    @r4.tag = @tag2
    @r4.save
    
    
  end
  
  test 'cac' do
    hosts = [ 'cac.local', 'computationalartscorp.com' ]
    hosts.each do |h|
      @request.host = h
      get :home
      assert_response :redirect
      assert_redirected_to :controller => :cac, :action => :home
      
    end
  end
  
  test 'piousbox home' do
    hosts = [ 'piousbox.local', 'piousbox.com' ]
    hosts.each do |h|
      @request.host = h
      get :home
      
      assert_response :redirect
      assert_redirected_to :controller => :users, :action => :resume, :username => 'piousbox'
      
    end
  end
  
  test 'blog home' do
    @request.host = 'blog.test.local'
    
    # both reports should show
    get :home
    assert_response :success
    assert_template :home
    
    rs = assigns :reports
    
    assert_not_nil rs
    assert_equal 2, rs.length
    assert_equal @r1.name, rs[0].name
    assert_equal @r4.name, rs[1].name
    
  end
  
  
  test 'page title' do
    host = 'blog.test.local'
    @request.host = host
    get :home
    assert_select 'title', Tag.where( :domain => host ).first.name
  end
  
  test 'ish' do
    hosts = [ 'ish.local', 'infiniteshelter.com' ]
    hosts.each do |h|
      @request.host = h
      get :home
      assert_response :redirect
      assert_redirected_to :controller => :ish, :action => :home
      
    end
  end
  
end