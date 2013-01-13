
require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'blog.test.local'
   
    Tag.all.each { |t| t.remove }
    FactoryGirl.create :tag
    FactoryGirl.create :tag_feature_1

    Report.all.each { |t| t.remove }
    
  end
  
  test 'get show' do
    Tag.all.each { |t| t.remove }
    
    @tag = Tag.create :name => 'blah blah', :name_seo => 'name_1', :domain => 'test.local', :user => User.all.first
    
    get :show, :name_seo => @tag[:name_seo]
    assert_response :success
    assert_template :show
    
  end
  
  test "should get index" do
    get :index
    assert_response :success
    tags = assigns(:tags)
    assert_not_nil tags
    
    feature_tags = assigns :feature_tags
    assert_not_nil feature_tags
    assert_equal 'Tag', feature_tags[0].class.name

  end
  
end
