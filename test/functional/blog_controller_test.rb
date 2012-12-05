
require 'test_helper'

class BlogControllerTest < ActionController::TestCase
  
  setup do
    Report.all.each { |d| d.remove }
    Site.all.each { |s| s.remove }
    
    @request.host = 'blog.test.local'
   
    clear_tags    
    
    @r1 = FactoryGirl.create :r1

    @tag2 = Tag.create :name => 'Tag 2',
      :parent_tag => Tag.where(:domain => 'blog.test.local').first

    @r4 = FactoryGirl.create :r4
    @r4.tag = @tag2
    @r4.save

    @r12 = FactoryGirl.create :r12
    @r13 = FactoryGirl.create :r13

    @site = FactoryGirl.create :test_site
  end
  
  test 'get about' do
    get :about
    assert_response :success
    assert_template :about
    
  end
  
  test 'get home' do
    get :home
    assert_response :success
    assert_template :home
    
    rs = assigns :reports
    
    assert_not_nil rs
    assert_equal 2, rs.length
  end

  
end