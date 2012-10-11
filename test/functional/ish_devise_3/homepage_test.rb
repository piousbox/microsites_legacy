require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  setup do
    @report = reports(:one)
		@report2 = reports(:two)
		@user = users(:one)
    @user_user = users(:user)
    @admin = users(:admin)
    
  end
  
  test 'feature galleries' do
    get :homepage
    
    feature_galleries = assigns :feature_galleries
    assert_not_nil feature_galleries
    
    feature_galleries.each do |gg|
      assert_equal 1, gg[:is_public]
      assert (1 == gg[:is_feature]) || (true == gg[:is_feature])
    end
    
    assert Gallery.n_features >= feature_galleries.length
  end
  
end
