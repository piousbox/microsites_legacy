

class WelcomeControllerTest < ActionController::TestCase
  
  setup do
    ;
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
    assert_response :redirect
    assert_redirected_to :controller => :blog, :action => :home
    
    
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
  
  test 'travel' do
    hosts = [ 'travel.local', 'travel-guide.mobi' ]
    hosts.each do |h|
      @request.host = h
      get :home
      assert_response :redirect
      assert_redirected_to :controller => :travel, :action => :home
      
    end
  end
  
end