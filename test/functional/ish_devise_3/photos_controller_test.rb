
require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  
  setup do
    @photo = photos(:one)
    @admin = users(:admin)
    @user = users(:user)
    
    @g = Gallery.find_by_user_id @admin[:id]
    assert @g.is_a? Gallery
    
    @request.env['HTTP_REFERER'] = 'http://test.host/'
  end
  
  test 'post move' do
    photo_id = 5
    gallery_id = 3
    
    result = Photo.find(photo_id)
    assert_not_equal gallery_id, result[:gallery_id]
    
    sign_in :user, @admin
    
    get :show, :id => 1
    post :move, :photo_id => photo_id, :gallery_id => gallery_id
    assert_response :redirect
    # why this no worky?
    # assert_redirected_to '/photos/1' # it should redirect to the previous URL
    assert_not_nil flash[:notice]
   
    result = Photo.find(photo_id)
    assert_equal gallery_id, result[:gallery_id]
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photos)
  end

  test "should get new" do
    sign_in :user, @admin
    
    get :new
    assert_response :success
  end

  test "should create photo" do
    sign_in :user, @admin
    
    assert_difference('Photo.count') do
      post :create, :photo => @photo.attributes
    end

    assert_redirected_to photo_path(assigns(:photo))
  end
  
  test 'driver' do
    # sign_in :user, @admin
    
    
    get :driver, :gallery_id => @g[:id]
    
    assert_response :success
    assert_template :driver

  end
  
  test 'create for gallery' do
    sign_in :user, @admin
    
    assert_difference('Photo.count') do
      post :create_for_gallery, :user_id => @admin[:id], :gallery_id => @g[:id]
    end
    assert_response :success
    assert_template :nothing
    
  end
  

  #	test '.set_profile_photo' do
  #    
  #		sign_in :user, @admin
  #    photo_id = 100
  #    
  #		post :set_profile_photo, :id => photo_id
  #    
  #		result = User.find(@admin.id)
  #		assert_equal photo_id, result[:profile_photo_id]
  #	end

  test "should show photo" do
    sign_in :user, @admin
    
    get :show, :id => @photo.to_param
    assert_response :success

  end

  test "should get edit" do
    sign_in :user, @admin
    
    get :edit, :id => @photo.to_param
    assert_response :success
  end

  test "should update photo" do
    sign_in :user, @admin
    
    put :update, :id => @photo.to_param, :photo => @photo.attributes
    assert_redirected_to photo_path(assigns(:photo))
  end

  test "should set user_id upon create" do
		photo = { :name => 'asdfq3rf123' }
		
		sign_in :user, @user

		post :create, :photo => photo
		assert_response :redirect
		
		result = Photo.find_by_name photo[:name]
		assert_equal @user.id, result[:user_id], 'user_id must be saved upon create'
	end
  
  test 'new profile photo' do
    
    sign_in :user, @admin
    p = { :gallery_id => 5 }
    
    post :create, :photo => p,
      :new_profile_photo => 1
    
    new_user = User.find @admin[:id]
    
    new_photo = Photo.find :first,
      :order => 'id desc'
    
    assert_equal new_photo[:id], new_user[:profile_photo_id]
     
  end
end
