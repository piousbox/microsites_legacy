

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
    
    @request.host = 'blog.test.local'
  end
  
  test 'blog home' do
    
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
    get :home
    assert_select 'title', Tag.where( :domain => 'blog.test.local' ).first.name
  end
  
  
end