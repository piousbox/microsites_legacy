

class PhotosController < ApplicationController
  
  load_and_authorize_resource

  def create

    @photo = Photo.new( params[:photo] )
    verified = true
    if @current_user.blank?
      verified = verify_recaptcha( :model => @photo, :message => 'There is a problem with recaptcha.' )
    else
      @photo.user = @current_user
    end

    if verified
      if @photo.save

        # news for myself
        n = Newsitem.new {}
        n.photo = @photo
        n.descr = 'uploaded new photo on'
        n.username = @current_user.username
        current_user.newsitems << n
        current_user.save || flash[:error] = 'Could not save newsitem for myself.'

        # only for viewers
        unless params[:photo][:viewer_ids].blank?
          params[:photo][:viewer_ids].each do |uid|
            user = User.find uid
            user.newsitems << n
            user.save || (puts! user.errors && flash[:error] = 'Newsitem for viewer could not be saved.' )
          end
        end

        # only for the city
        if !params[:photo][:city_id].blank? && @photo.is_public
          city = City.find params[:photo][:city_id]

          nn = Newsitem.new {}
          nn.photo = @photo
          nn.descr = 'uploaded new photo on'
          nn.username = @current_user.username

          city.newsitems << nn
        
          flag = city.save
          unless flag
            puts! city.errors
            flash[:error] = 'City could not be saved (newsitem).'
          end
        end

        unless params[:photo][:report_id].blank?
          report = Report.find params[:photo][:report_id]
          report.photo = @photo
          report.save || flash[:error] = 'Did not save report of this photo'
        end

        if params[:set_as_profile_photo]
          @current_user.profile_photo = @photo
          @current_user.save || flash[:error] = flash[:error] + " Did not set as profile photo"
        end

        flash[:notice] = 'Success'
        redirect_to :controller => :users, :action => :organizer

      else
        render :action => :new

      end
    end
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

  #  def show
  #    ;
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