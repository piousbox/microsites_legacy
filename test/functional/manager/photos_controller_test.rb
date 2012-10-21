
require 'test_helper'

class Manager::PhotosControllerTest < ActionController::TestCase
  
  setup do
    @u = User.all[0]
  end
  
  test 'destroy' do
    assert false, 'todo'
  end
  
  test 'move' do
    g1 = Gallery.create :name => 'blah blah', :user => @u, :galleryname => 'a1'
    g2 = Gallery.create :name => 'blah blah 2', :user => @u, :galleryname => 'a2'
    
    photo = Photo.create :descr => 'photo descr', :user => @u, :gallery => g1
    
    post :move, :id => photo._id, :photo => { :gallery_id => g2._id }
    
    new_photo = Photo.where( :descr => photo.descr ).first
    assert_equal g2.descr, new_photo.gallery.descr
    
  end

end
