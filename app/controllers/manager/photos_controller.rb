

class Manager::PhotosController < ManagerController
  
  def destroy
    @photo = Photo.find params[:id]
    @photo.is_trash = true
    if @photo.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    
    redirect_to manager_gallery_path(@photo.gallery.galleryname)
    
  end
  
end