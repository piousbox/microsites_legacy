

class PhotosController < ApplicationController
  
  def upload
    @photo = Photo.new
    
  end
  
  def do_upload
    @photo = Photo.new( params[:photo] )
    @photo.user = @current_user
    
    if @photo.save
      
      if params[:set_as_profile_photo]
        @current_user.profile_photo = @photo
        if @current_user.save 
          flash[:notice] = 'Success saving picture and setting it as profile picture'
        else
          flash[:notice] = 'Success saving picture, but setting profile picture failed.'
        end
      else
        flash[:notice] = 'Success saving picture'
      end
      
      redirect_to :controller => :users, :action => :organizer
      
    else
      flash[:error] = 'Did not work.'
      render :upload
    end
  end
  
end