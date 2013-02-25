
class GalleriesController < ApplicationController

  rescue_from Mongoid::Errors::DocumentNotFound do
    flash[:error] = 'Gallery not found.'
    redirect_to galleries_path
  end

  def index
    authorize! :index, Gallery.new

    @galleries = Gallery.all

    if params[:cityname]
      city = City.where( :cityname => params[:cityname] ).first
      @galleries = @galleries.where( 'city' => city )
    end

    if params[:my]
      @galleries = @galleries.where( :user => current_user )
    end

    @galleries = @galleries.page( params[:galleries_page] )

    respond_to do |format|
      format.html do
        if params[:my]
          render :layout => 'organizer', :action => 'my_index'
        elsif '1' == @is_mobile
          render :layout => 'organizer'
        else
          render
        end
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
    @newsitems = @site.newsitems.page( params[:newsitems_page] )
    
    if params[:galleryname].blank?
      authorize! :not_found, Gallery.new
      @gallery = Gallery.find params[:id]
      if @gallery.galleryname.blank?
        @gallery.galleryname = @gallery.name.to_simple_string
        @gallery.save
      end
      redirect_to gallery_path @gallery.galleryname
      
    else
      if @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
        authorize! :show, @gallery

        respond_to do |format|
          format.html do
            layout = params[:layout] || 'application'
            @photos = @gallery.photos.fresh
            
            unless @gallery.city.blank?
              @city = @gallery.city
              @galleryname = @gallery.galleryname
            end

            action = 'show_mini'
            if !cookies[:galleries_show_style].blank? && Gallery.styles.include?( cookies[:galleries_show_style] )
              action = cookies[:galleries_show_style]
            end

            render :action => action, :layout => layout
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
        render :layout => 'organizer'
      end
      format.json { render :json => @gallery }
    end
  end

  def create
    @gallery = Gallery.new(params[:gallery])
    @gallery.user = current_user
    @gallery.username = current_user.username
    authorize! :create, @gallery

    if @gallery.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end

    # for the city
    if !params[:gallery][:city_id].blank? && @gallery.is_public
      city = City.find params[:gallery][:city_id]

      n = Newsitem.new {}
      n.gallery = @gallery
      n.descr = 'created new gallery on'
      n.username = @current_user.username

      city.newsitems << n
      flag = city.save
      unless flag
        flash[:error] = 'City could not be saved (newsitem). '
      end
    end

    # for the homepage
    if @gallery.is_public
      n = Newsitem.new {}
      n.gallery = @gallery
      n.descr = 'created new gallery on'
      n.username = @current_user.username
      @site.newsitems << n
      flag = @site.save
      unless flag
        flash[:error] = flash[:error] + 'Newsitem for site could not be saved. '
      end
    end

    redirect_to my_galleries_path
  end

  def edit
    if params[:id]
      @gallery = Gallery.find( params[:id] )
    else
      @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    end
    authorize! :edit, @gallery
    
    @cities = City.list
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
    
    @galleries = Gallery.where( :user => current_user, :name => /#{params[:search_keyword]}/i ).page( params[:galleries_page] )
    
    render :action => :index, :layout => 'organizer'
  end

  def show_photo
    @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    authorize! :show_photo, @gallery
    render :layout => @layout
  end

  def set_show_style
    authorize! :set_show_style, Gallery.new
    cookies[:galleries_show_style] = params[:style]
    flash[:notice] = 'Attempted setting display style for galleries/show'
    redirect_to request.referrer
  end
  
end


