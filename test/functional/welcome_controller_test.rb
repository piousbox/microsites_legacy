

class WelcomeControllerTest < ActionController::TestCase
  
  setup do
    clear_reports
    clear_tags
    setup_host
    
  end
  
  test 'get homepage' do
    get :homepage
    assert_response :success
    assert_template :homepage
    
  end
  
  test 'reports from all tags show up on homepage' do
    @controller = WelcomeController.new
    @r1 = Report.create :name => 'r1', :tag => @main_tag
    @tag2 = Tag.create :name => 'tag 2', :parent_tag => @main_tag
    @r2 = Report.create :name => 'r2', :tag => @tag2
    
    # both reports should show
    get :homepage
    rs = assigns :reports
    
    assert_not_nil rs
    assert_equal 2, rs.length
    assert_equal 'r1', rs[0].name
    assert_equal 'r2', rs[1].name
    
  end
  
end