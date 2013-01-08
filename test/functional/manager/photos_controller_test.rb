
require 'test_helper'

class Manager::PhotosControllerTest < ActionController::TestCase
  
  setup do
    User.clear
    @u = FactoryGirl.create :user
    @manager = FactoryGirl.create :manager

    setup_photos

    Gallery.all.each { |g| g.remove }
  end
  
  test 'move' do
    g1 = Gallery.create :name => 'blah blah', :user => @u, :galleryname => 'a1', :descr => 'blah blah'
    g2 = FactoryGirl.create :g3
    assert_not_nil g2
    
    photo = Photo.first
    
    post :move, :id => photo.id, :photo => { :gallery_id => g2.id }
    assert_response :redirect
    
    assert_not_nil Photo.find( photo.id )
    new_photo = Photo.find( photo.id )
    assert_not_nil new_photo
    assert_equal 'Photo', new_photo.class.name
    assert_equal g2.descr, new_photo.gallery.descr
    
  end

end
