
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
    @controller.stub!(:current_user).and_return( @user )
    
    photo = { :descr => 'blah blah 2222' }
    post :do_upload, :photo => photo
    assert_response :redirect
    
    p = Photo.where( :descr => photo[:descr] ).first
    assert_not_nil p
    assert_equal 'Photo', p.class.name
    assert_not_nil p.user
    assert_equal @user.username, p.user.username
  end
  
  
#  test 'post move' do
#    photo_id = 5
#    gallery_id = 3
#    
#    result = Photo.find(photo_id)
#    assert_not_equal gallery_id, result[:gallery_id]
#    
#    sign_in :user, @admin
#    
#    get :show, :id => 1
#    post :move, :photo_id => photo_id, :gallery_id => gallery_id
#    assert_response :redirect
#    # why this no worky?
#    # assert_redirected_to '/photos/1' # it should redirect to the previous URL
#    assert_not_nil flash[:notice]
#   
#    result = Photo.find(photo_id)
#    assert_equal gallery_id, result[:gallery_id]
#  end
#
#  
#  
#  test 'driver' do
#    # sign_in :user, @admin
#    
#    
#    get :driver, :gallery_id => @g[:id]
#    
#    assert_response :success
#    assert_template :driver
#
#  end
#  
#  test 'create for gallery' do
#    sign_in :user, @admin
#    
#    assert_difference('Photo.count') do
#      post :create_for_gallery, :user_id => @admin[:id], :gallery_id => @g[:id]
#    end
#    assert_response :success
#    assert_template :nothing
#    
#  end
  
end