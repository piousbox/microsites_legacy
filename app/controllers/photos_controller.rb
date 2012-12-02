

class PhotosController < ApplicationController
  
  load_and_authorize_resource

  def create
    @photo = Photo.new( params[:photo] )
    @photo.report = Report.find params[:photo][:report_id]
    @photo.user = @current_user
    
    if @photo.save
      
      if params[:set_as_profile_photo]
        @current_user.profile_photo = @photo
        if @current_user.save 
          flash[:notice] = 'Success saving Photo and setting it as profile Photo'
        else
          flash[:notice] = 'Success saving Photo, but setting profile Photo failed.'
        end
      else
        flash[:notice] = 'Success saving Photo'
      end
      
      redirect_to :controller => 'manager/welcome', :action => :homepage
      
    else
      flash[:error] = 'Did not work.'
      render :upload
    end
  end
  
  def driver
    authorize! :driver, Photo.new
    
    @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    
    respond_to do |format|
      format.html do
        render :layout => 'manager'
      end
      format.json { render :json => {}.to_json }
    end
  end

  def do_upload
    p = Photo.new 
    p.photo = params[:Filedata].tempfile
    p.gallery_id = params[:gallery_id]
    p.user = User.where( :email => 'piousbox@gmail.com' ).first
    p.save
  end

  def new
    @photo = Photo.new
    @citis = City.list
    @report = Report.list
    @galleries = Gallery.list
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    render :json => true
  end

  #  def move
  #    photo_id = params[:photo_id]
  #    gallery_id = params[:gallery_id]
  #
  #    photo = Photo.find(photo_id)
  #    photo[:gallery_id] = gallery_id
  #
  #    if photo.save
  #      flash[:notice] = 'Success moving a photo to a new gallery.'
  #    else
  #      flash[:error] = 'Failure to move a photo, contact admin?'
  #    end
  #
  #    redirect_to request.referrer
  #  end
  #
  #  def update
  #    @photo = Photo.find(params[:id])
  #
  #    respond_to do |format|
  #      if @photo.update_attributes(params[:photo])
  #        format.html { redirect_to @photo, :notice => 'Photo was successfully updated.' }
  #        format.json { head :ok }
  #      else
  #        format.html { render :action => "edit" }
  #        format.json { render :json => @photo.errors, :status => :unprocessable_entity }
  #      end
  #    end
  #  end
  #
  #  private
  #
  #  def set_galleries
  #    @galleries = [['No Parent', nil]] + Gallery.find(:all,
  #      :conditions => ['is_public = 1 or user_id = ?', current_user[:id] ],
  #      :order => 'name desc'
  #    ).map { |item| [ item.name, item.id ] }
  #  end

end