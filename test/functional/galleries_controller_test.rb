require 'test_helper'

class GalleriesControllerTest < ActionController::TestCase

  setup do
    User.all.each { |d| d.remove}
    
    @admin = FactoryGirl.create :admin
    
		sign_in :user, @admin
  end
  
  test 'index' do
    get :index
    assert_response :success
    assigns(:galleries).length.should > 1
    response.should render_template 'galleries/index'
    assigns(:galleries).each_with_index do |gallery, idx|
      if idx + 1 == assigns(:galleries).length
        ;
      else
        gallery.created_at.should >= assigns(:galleries)[idx+1].created_at
      end
    end
  end
  
  test 'get new' do
    get :new
    assert_response :success
    assert_template :new    
  end
  
end
