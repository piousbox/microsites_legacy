
require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'blog.test.local'
   
    clear_tags
    clear_reports
    
    
    
  end
  
  test 'get show' do
    @tag = Tag.create :name => 'blah blah', :name_seo => 'name_1', :domain => 'test.local'
    get :show, :name_seo => @tag[:name_seo]
    assert_response :success
    assert_template :show
    
  end

  
end