
class PhotosController < ApplicationController

  skip_authorization_check :only => [ :do_upload ]
  before_filter :sett_lists

  def j_create
    @photo = Photo.new( params[:photo] )
    authorize! :create, @photo
    @photo.is_public = true
   
    if params[:galleryname]
      gallery = Gallery.where( :galleryname => params[:galleryname] ).first
      @photo.gallery_id = gallery.id
    elsif params[:gallery_id]
      gallery = Gallery.find( params[:gallery_id] )
      @photo.gallery_id = gallery.id
    end
   
    # @TODO this is badd
    @photo.user = User.where( :username => 'anon' ).first

    if @photo.save
      j = { :name => @photo.photo.original_filename,
        :size => @photo.photo.size,
        :url => @photo.photo.url( :large ),
        :thumbnail_url => @photo.photo.url( :thumb ),
        :delete_url => photo_path(@photo),
        :delete_type => 'DELETE',
        :name => @photo.name
      }
      render :json => [ j ]
    else
      render :json => { "errors" => @photo.errors } 
    end
  end

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
    
    if params[:galleryname]
      gallery = Gallery.where( :galleryname => params[:galleryname] ).first
      @photo.gallery_id = gallery.id
    elsif params[:gallery_id]
      gallery = Gallery.find( params[:gallery_id] )
      @photo.gallery_id = gallery.id
    end

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

        # create newsitem for the site
        if params[:photo][:is_public] && params[:photo][:create_newsitems] == '1'
          n = Newsitem.new
          n.photo = @photo
          sites = Site.where( :domain => @domain )
          sites.each do |site|
            site.newsitems << n
            site.save
            expire_page :controller => 'sites', :action => 'show', :domainname => site.domain, :locale => site.lang
          end
          unless @photo.gallery_id.blank?
            expire_page :controller => 'galleries', :action => 'show', :galleryname => Gallery.find( @photo.gallery_id ).galleryname
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
        
        respond_to do |format|
          format.html do
            redirect_to :controller => :users, :action => :organizer
          end
          format.json
        end
      else
        pfft
        render :action => :new
      end
    else
      pfft
      render :action => :new
    end
  end

  def new
    @photo = Photo.new
    authorize! :new, @photo

    pfft

    if params[:gallery_id]
      render :action => :new_for_gallery
    else
      if params[:is_profile]
        render :action => :new_profile_photo
      else
        render
      end
    end
  end

  def multinew
    @photo = Photo.new
    @gallery = Gallery.find_by( :galleryname => params[:galleryname] )
    @cities_list = City.list
    authorize! :new, @photo
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    authorize! :destroy, @photo
    @photo.is_trash = true 
    if @photo.save
      render :json => :ok
    else
      render :json => @photo.errors
    end
  end

  def update
    @photo = Photo.find( params[:id] )
    authorize! :update, @photo

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, :notice => 'Photo was successfully updated.' }
        format.json { head :ok }
      else
        puts! @photo.errors
        format.html { render :action => "edit" }
        format.json { render :json => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def pfft
    @reports = Report.list
    @galleries = Gallery.or({ :user => current_user },
                            { :is_anonymous => true }).list
    @friends = User.list
    @list_users = User.list
  end

end
