

class Manager::GalleriesController < ManagerController
  
  def index
    @galleries = Gallery.all
  end
  
  def all_photos
    @photos = Photo.all
    
  end
  
  def show
    @gallery = Gallery.where( :galleryname => params[:id] ).first
    @galleries = Gallery.list
    
  end
  
  def new
    @gallery = Gallery.new
  end
  
end