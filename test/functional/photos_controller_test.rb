
require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'travel.local'
    @user = FactoryGirl.create :user
    
  end
  
  test 'get upload' do
    get :upload
    assert_response :success
    assert_template :upload
    assert_not_nil assigns( :photo )
  end
  
  test 'POST do_upload' do
    
    sign_in :user, @user
    
    photo = { :descr => 'blah blah 2222' }
    post :do_upload, :photo => photo
    assert_response :redirect
    
    p = Photo.where( :descr => photo[:descr] ).first
    assert_not_nil p
    assert_equal 'Photo', p.class.name
    assert_not_nil p.user
    assert_equal @user.username, p.user.username
  end
  
end