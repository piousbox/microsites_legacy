require 'test_helper'

class My::GalleriesControllerTest < ActionController::TestCase
  setup do
    
    @g1 = galleries :one
    @g2 = galleries :two
    
    @event = events(:one)
		@admin = users(:admin)

		sign_in :user, @admin
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert_not_nil assigns :galleries
    
  end
  
  test 'delete' do
    sign_in :user, @admin
    
    id = 888
    id_2 = 889
    gallery = Gallery.find(id_2)
    
    delete :destroy, :id => gallery[:id]
    assert_response :redirect
    
    gallery = Gallery.find id_2
    assert_equal 1, gallery[:is_trash]
    
  end
  
  test 'get edit' do
    sign_out :user
    sign_in :user, @admin
    
    g = Gallery.find :first
    
    get :edit, :id => g[:id]
    assert_response :success
    
  end
  
  test 'put update' do
    existing = Gallery.find :first
    sign_in :user, @admin
    
    g = { :name => 'blah blah 57890' }
    put :update, :gallery => g, :id => existing[:id]
    assert_response :redirect
    
    new = Gallery.find_by_name g[:name]
    assert_equal 'Gallery', new.class.name
    
  end
  
end