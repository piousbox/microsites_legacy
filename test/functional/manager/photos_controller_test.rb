
require 'test_helper'

class Manager::PhotosControllerTest < ActionController::TestCase
  
  setup do
    User.clear
    @u = FactoryGirl.create :user
    @manager = FactoryGirl.create :manager
    sign_in :user, @manager
    
    setup_photos

    Gallery.all.each { |g| g.remove }
  end

  test 'new' do
    get :new
    assert_response :success
  end
  
  test 'move' do
    assert false, 'todo - replace by method `update`'
    
    g1 = Gallery.create :name => 'blah blah', :user => @u, :galleryname => 'a1', :descr => 'blah blah'
    assert_equal 'Gallery', g1.class.name
    assert_equal 'blah blah', g1.name

    g2 = FactoryGirl.create :g3
    assert_not_nil g2
    assert_equal 'Gallery', g2.class.name

    photo = Photo.all[0]
    photo.user = User.all[0]
    assert photo.save
    assert_equal 'Photo', photo.class.name
    assert_not_nil photo.user
    
    post :move, :id => photo.id, :photo => { :gallery_id => g2.id }
    assert_response :redirect
    
    new_photo = Photo.find( photo.id )
    assert_not_nil new_photo
    new_g = new_photo.gallery
    assert_equal g2, new_g
    
  end

end
