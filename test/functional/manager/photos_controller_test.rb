
require 'test_helper'

class Manager::PhotosControllerTest < ActionController::TestCase
  
  setup do
    # Photo.all.each { |k| k.remove }
    
    @u = User.all[0]
  end
  
  test 'move' do
    g1 = Gallery.create :name => 'blah blah', :user => @u, :galleryname => 'a1', :descr => 'blah blah'
    g2 = FactoryGirl.create :g3
    
    photo = Photo.create :descr => 'photo descr', :user => @u, :gallery => g1
    
    post :move, :id => photo._id, :photo => { :gallery_id => g2._id }
    assert_response :redirect
    
    assert_equal 1, Photo.where( :descr => photo.descr ).length
    new_photo = Photo.where( :descr => photo.descr ).first
    assert_not_nil new_photo
    assert_equal 'Photo', new_photo.class.name
    assert_equal g2.descr, new_photo.gallery.descr
    
  end

end
