require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  
  setup do
    @tag = tags(:one)
    @admin = users :admin
    @user = users :user
  end
  
  test 'should get index_small' do
    get :index_small
    
    assert_response :success
    assert_not_nil assigns(:tags)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    tags = assigns(:tags)
    assert_not_nil tags
    assert tags.length <= 10
  end

  test "should show tag" do
    get :show, :id => @tag.to_param
    
    assert_not_nil assigns :tag

  end
  
  test 'should show with string id' do
#    get :show, :name_seo => 'nonexistent 234rf'
#    assert_response :redirect
#    assert_redirected_to tags_path
#    assert_not_nil flash[:notice]
    
    name_seo = 'sedux_seo'
    get :show, :name_seo => name_seo
    assert_response :success
    
    tag = assigns(:tag)
    assert_not_nil tag
    assert_equal name_seo, tag[:name_seo]
    assert_equal 1, tag[:is_public]
  end
  
  

end
