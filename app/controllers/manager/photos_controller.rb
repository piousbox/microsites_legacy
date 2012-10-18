

class Manager::PhotosController < ManagerController
  
  def destroy
    @photo = Photo.find params[:id]
    
    if @photo.remove
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    
    redirect_to manager_gallery_path(@photo.gallery.galleryname)
    
  end
  
end