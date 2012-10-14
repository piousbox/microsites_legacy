#require 'test_helper'
#
#class GalleriesControllerTest < ActionController::TestCase
#  setup do
#    
#    @g1 = galleries :one
#    @g2 = galleries :two
#    
#    @event = events(:one)
#		@admin = users(:admin)
#
#		sign_in :user, @admin
#  end
#  
#  test 'get index_2' do
#    get :index_2
#    assert_response :success
#    assert_not_nil assigns :galleries
#    
#  end
#  
#  test 'shuffle photos' do
#    sign_in :user, @admin
#    
#    id = 888
#    id_2 = 889
#    gallery = Gallery.find(id_2)
#    
#    get :show, :id => gallery[:id]
#    assert_response :redirect
#    
#    get :show, :id => id_2
#    assert_redirected_to :action => :show, :name_seo => gallery[:name_seo], :photo_id => 0, :id => nil
#    
##    my_galleries = assigns(:my_galleries)
##    assert_not_nil my_galleries
#  end
#  
#  test 'free photo hosting page exists' do
#    get :free_photo_hosting
#    assert_response :success
#    assert_template :free_photo_hosting
#    
#  end
#
#  test 'gallery that is not mine, does not display move-to selector' do
#    sign_out :user
#    
#    id = 2
#    
#    get :show, :id => id
#    gallery = Gallery.find(id)
#    assert_not_equal gallery[:user_id], @admin.id # the signed in user does not own this gallery
#    assert_select '#moveSubmit', false
#  end
#  
#  test 'index' do
#    get :index
#    assert_response :success
#  end
#  
#  test 'get new' do
#    get :new
#    assert_response :success
#    assert_template :new
#    
#  end
#end