

class Manager::GalleriesController < ManagerController
  
  def index
    @galleries = Gallery.all
  end
  
  def all_photos
    @photos = Photo.all
    
  end
  
end