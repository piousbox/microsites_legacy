

class PhotosController < ApplicationController
  
  def upload
    @photo = Photo.new
    
  end
  
  def do_upload
    @photo = Photo.new( params[:photo] )
    @photo.user = @current_user
    
    if @photo.save
      flash[:notice] = 'Success'
      redirect_to :controller => :users, :action => :organizer
      
    else
      flash[:error] = 'Did not work.'
      render :upload
    end
  end
  
end