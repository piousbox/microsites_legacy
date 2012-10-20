

class PhotosController < ApplicationController
  
  load_and_authorize_resource
  
  #  def churn_photos
  #    authorize! :churn_photos, Photo.new
  #    
  #    puts! params[:photos][0]
  #    puts! params[:photos][0].tempfile
  #    
  #    params[:photos].each do |ph|
  #      @photo = Photo.new ph
  #      @photo.user = User.where( :email => 'piousbox@gmail.com' ).first
  #      @photo.save
  #      puts! @photo.photo.url(:original)
  #    end
  #    
  #    respond_to do |format|
  #      format.html do
  #        render 'index'
  #      end
  #      format.json do
  #        
  #        js = {}
  #        js['name'] = 'blah'
  #        js['size'] = 902604
  #        js['url'] = @photo.photo.url(:original)
  #        js['thumbnail_url'] = @photo.photo.url(:thumb)
  #        js['delete_url'] = '/'
  #        js['delete_type'] = 'DELETE'
  #    
  #        render :json => [js]
  #      end
  #    end
  #  end
  
  def create
    
    @photo = Photo.new( params[:photo] )
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
      
      redirect_to :controller => :users, :action => :organizer
      
    else
      flash[:error] = 'Did not work.'
      render :upload
    end
  end
  
  #  def move
  #    ;
  #  end
  #  
  #  def driver
  #    authorize! :driver, Photo.new
  #    
  #    @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
  #    
  #    respond_to do |format|
  #      format.html # index.html.erb
  #      format.json { render :json => {}.to_json }
  #    end
  #  end
  # 
  #  
  #  def create_for_gallery
  #    
  #    p = {}
  #    p[:photo] = params[:Filedata]
  #    p[:descr] = params[:Filename]
  #    p.user = User.where( :email => 'piousbox@gmail.com' ).first
  #    
  #    @photo = Photo.new(p)
  #    @photo.save
  #    
  #    respond_to do |f|
  #      f.html do
  #        render :nothing, :layout => false    
  #      end
  #    end
  #  end
  #
  #  def index
  #    @photos = Photo.all
  #    render :json => @photos.collect { |p| p.to_jq_upload }.to_json
  #  end

  def new
    @photo = Photo.new
    
  end
    
  

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    render :json => true
  end
  
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
#
#  
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
#
#end
