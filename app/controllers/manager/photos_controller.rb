

class Manager::PhotosController < ManagerController
  
  def destroy
    @photo = Photo.find params[:id]
    
    unless @photo.gallery.blank?
      galleryname = @photo.gallery.galleryname
    end
    
    if @photo.remove
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    
    if galleryname.blank?
      redirect_to manager_photos_no_gallery_path
    else
      redirect_to manager_gallery_path(galleryname)
    end
    
  end
  
  def move
    
    puts! params
    
    @photo = Photo.find params[:id]
    
    old_galleryname = @photo.gallery.galleryname
    
    g = Gallery.find(params[:photo][:gallery_id])
    @photo.gallery = g
    
    if @photo.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    
    redirect_to manager_gallery_path(old_galleryname)
  end
  
  def no_gallery
    @photos = Photo.where( :gallery => nil, :report => nil, :city => nil, :profile_user => nil )
    render 'index'
    
  end
  
end