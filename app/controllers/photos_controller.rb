
class PhotosController < ApplicationController

  skip_authorization_check :only => [ :do_upload ]
  
  def create

    @photo = Photo.new( params[:photo] )
    authorize! :create, @photo
    
    verified = true
    if current_user.blank?
      verified = verify_recaptcha( :model => @photo, :message => 'There is a problem with recaptcha.' )
      @photo.user = User.where( :username => 'anon' ).first
    else
      @photo.user = @current_user
    end
    @photo.username = @photo.user.username
    
    if verified
      if @photo.save

        if !@current_user.blank? && @current_user.create_newsitem(:photo => @photo)
          flash[:notice] = 'Created newsitem for current user.'
        else
          flash[:error] = 'Could not create newsitem for current user.'
        end
        
        # only for viewers
        unless params[:photo][:viewer_ids].blank?
          params[:photo][:viewer_ids].each do |uid|
            user = User.find uid
            user.newsitems << Newsitem.new({ :descr => 'New photo', :photo => @photo, :username => @photo.user.username })
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

        if params[:photo][:set_as_profile_photo]
          unless @current_user.blank?
            @current_user.profile_photo = @photo
            @current_user.save
          end
        end

        flash[:notice] = 'Success'
        redirect_to :controller => :users, :action => :organizer

      else
        pfft
        render :layout => params[:layout], :action => :new
        
      end
    else
      pfft
      render :action => :new

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
    p.is_trash = false
    flag = p.save
    unless flag
      puts! p.errors
    end
    
  end

  def new
    @photo = Photo.new
    authorize! :new, @photo

    if params[:is_profile]
      @is_profile = true
    end

    pfft

    if params[:gallery_id]
      render :layout => 'organizer', :action => :new_for_gallery
      
    else
      if @is_profile
        render :layout => 'organizer', :action => :new_profile_photo
      else
        render :layout => 'organizer'
      end
    end
    
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    authorize! :destroy, @photo

    # @photo.destroy
    
    render :json => true
    
  end

  def show
    @photo = Photo.find params[:id]
    authorize! :show, @photo
    
  end

  def update
    @photo = Photo.find(params[:id])
    authorize! :update, @photo

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

  ##
  ## private begins
  ##
  private

  def pfft
    @citis = City.list
    @reports = Report.list
    @galleries = Gallery.list
    @friends = User.list
    @list_users = User.list
    @list_venues = Venue.list

  end

end