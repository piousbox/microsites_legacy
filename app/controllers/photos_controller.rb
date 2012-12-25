

class PhotosController < ApplicationController
  
  load_and_authorize_resource

  def create

    @photo = Photo.new( params[:photo] )
    @photo.user = @current_user

    flag = @photo.save
    if flag


      unless params[:photo][:city_id].blank? || false == params[:photo][:is_public]
        city = City.find params[:photo][:city_id]

        n = Newsitem.new
        n.photo = @photo
        n.descr = 'uploaded new photo on'
        n.user = current_user
        city.newsitems << n
        if city.save
        else
          flash[:error] = 'City could not be saved (newsitem).'
        end
      end

      unless params[:photo][:report_id].blank?
        report = Report.find params[:photo][:report_id]
        report.photo = @photo
        if report.save
          ;
        else
          flash[:error] = 'Did not save report of this photo'
        end
      end

      if params[:set_as_profile_photo]
        @current_user.profile_photo = @photo
        if @current_user.save
          ;
        else
          flash[:error] = flash[:error] + " Did not set as profile photo"
        end
      end
      
    else
      flash[:error] = 'Photo did not save'
      
    end

    if flag && flash[:error].blank?
      flash[:notice] = 'Success'
    end

    redirect_to :controller => :users, :action => :account
  end
  
  def driver
    authorize! :driver, Photo.new

    if params[:galleryname]
      @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    else
      @gallery = Gallery.find params[:gallery_id]
    end
    
    respond_to do |format|
      format.html do
        render :layout => 'organizer'
      end
      format.json { render :json => {}.to_json }
    end
  end

  def do_upload
    p = Photo.new 
    p.photo = params[:Filedata].tempfile
    p.gallery_id = params[:gallery_id]
    p.user = User.where( :username => params[:username] ).first
    p.save
  end

  def new
    @photo = Photo.new
    @citis = City.list
    @reports = Report.list
    @galleries = Gallery.list
    @friends = User.list
    
    # layout organizer set, 20121204
    render :layout => 'organizer'
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

  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, :notice => 'Photo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    ;
  end

  #  private
  #
  #  def set_galleries
  #    @galleries = [['No Parent', nil]] + Gallery.find(:all,
  #      :conditions => ['is_public = 1 or user_id = ?', current_user[:id] ],
  #      :order => 'name desc'
  #    ).map { |item| [ item.name, item.id ] }
  #  end

end