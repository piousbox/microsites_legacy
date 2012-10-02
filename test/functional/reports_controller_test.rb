
require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  
  setup do
#    ps = {
#      :name => 'article_name',
#      :subhead => 'subhead 1',
#      :descr => 'blah blah'
#    }
#    @article = Article.new ps
    
    setup_host
    clear_tags
    clear_reports
    
    # order matters
    @r1 = FactoryGirl.create :r1
    @tag2 = Tag.create :name => 'Tag 2',
      :parent_tag => Tag.where(:domain => 'test.local').first
    @r4 = FactoryGirl.create :r4
    @r4.tag = @tag2
    @r4.save
    

  end
  
  test 'get homepage' do
    get :homepage
    assert_response :success
    assert_template :homepage
    
  end
  
  test 'reports from all tags show up on homepage' do
    
    # both reports should show
    get :homepage
    rs = assigns :reports
    
    
    
    assert_not_nil rs
    assert_equal 2, rs.length
    assert_equal @r1.name, rs[0].name
    assert_equal @r4.name, rs[1].name
    
  end
  
  
end
