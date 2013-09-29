class GalleriesController < ApplicationController

  caches_page :index, self::CACHE_OPTIONS
  caches_page :show, self::CACHE_OPTIONS

  rescue_from Mongoid::Errors::DocumentNotFound do
    flash[:error] = 'Gallery not found.'
    redirect_to galleries_path
  end

  def index
    authorize! :index, Gallery.new

    @galleries = Gallery.where( :is_public => true, :is_trash => false ).order_by( :created_at => :desc )
    @galleries = @galleries.page( params[:galleries_page] )

    respond_to do |format|
      format.html do
        render
      end
      format.json do
        @g = []
        @galleries.each do |gallery|
          if gallery.photos[0]
            gallery[:photo_url] = gallery.photos[0].photo.url(:thumb)
          else
            gallery[:photo_url] = ''
          end
          gallery[:username] = gallery.user.username
          gallery.photos = gallery.photos.all
          @g.push gallery
        end
        render :json => @g
      end
    end
  end

  def show
    if params[:id]
      @g = Gallery.find params[:id]
      authorize! :not_found, @g
      if @g.galleryname.blank?
        @g.galleryname = @g.name.to_simple_string
        @g.save
      end
      redirect_to gallery_path(@g.galleryname, 0)
    else
      if @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
        authorize! :show, @gallery
        @photos = @gallery.photos.where( :is_trash => false )
        if @gallery.tag.blank?
          @related_galleries = []
        else
          @related_galleries = Gallery.where( :is_trash => false, :tag_id => @gallery.tag_id, :is_public => true,
                                              :site_id => @gallery.site.id ).order_by( :created_at => :desc ).page( params[:related_galleries_page] )
          @related_galleries = @related_galleries.to_a
          @related_galleries.each_with_index do |item, idx|
            if item.galleryname == @gallery.galleryname
              @related_galleries.delete_at idx
            end
          end
        end
        
        photo_idx = params[:photo_idx]
        if 0 == @photos.length
          render :action => :no_photos
        elsif !photo_idx.blank? && ( photo_idx.to_i > (@photos.length-1).to_i )
          redirect_to gallery_path(@gallery.galleryname, 0)
        else
          respond_to do |format|
            format.html do
              action = Gallery.actions.include?( params[:style] ) ? params[:style] : 'show'
              render :action => action
            end
            format.json do
              photos = []
              @gallery.photos.all.each do |ph|
                p = { :thumb => ph.photo.url(:thumb), :large => ph.photo.url(:large) }
                photos.push p
              end
              @gallery[:photoss] = photos
              
              unless 0 == @gallery.photos.length
                @gallery[:photo_url] = @gallery.photos[0].photo.url(:thumb)
              end
              @gallery[:photo_url] ||= ''

              render :json => @gallery
            end
          end
        end
        
      else
        authorize! :not_found, Gallery.new
        flash[:error] = 'Gallery not found'
        redirect_to :action => :index
      end
    end
  end
  
  def new
    @gallery = Gallery.new
    authorize! :new, @gallery

    respond_to do |format|
      format.html do
        @title = t('galleries.new')
        render :layout => 'resume'
      end
      format.json { render :json => @gallery }
    end
  end

  def create
    @gallery = Gallery.new(params[:gallery])
    @gallery.user = current_user
    authorize! :create, @gallery

    if @gallery.save
        expire_page :controller => 'galleries', :action => 'index'
        expire_page :controller => 'sites', :action => 'show'
      flash[:notice] = 'Success'
      redirect_to organizer_path
    else
      flash[:error] = 'No Luck. ' + @gallery.errors.inspect
      render :action => :new, :layout => 'resume'
    end
  end

  def edit
    if params[:id]
      @gallery = Gallery.find( params[:id] )
    else
      @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    end
    authorize! :edit, @gallery    
  end

  def update
    @g = Gallery.find params[:id]
    authorize! :update, @g
    
    if @g.update_attributes params[:gallery]
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to galleries_path
  end
  
  def search
    authorize! :search, Gallery.new
    @galleries = Gallery.where( :user => current_user, :name => /#{params[:q]}/i ).page( params[:galleries_page] )
    render :action => :index
  end

  def set_show_style
    authorize! :set_show_style, Gallery.new
    cookies[:galleries_show_style] = params[:style]
    flash[:notice] = 'Attempted setting display style for galleries/show'
    # redirect_to request.referrer
    redirect_to :action => :index
  end
  
end


