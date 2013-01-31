
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
      @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
      authorize! :show, @gallery
      
      if @gallery.blank?
        flash[:error] = 'Gallery not found'
        redirect_to :action => :index

      else
        respond_to do |format|
          format.html do
            layout = params[:layout] || 'application'
          
            if !@gallery.tag.blank? && @gallery.tag.domain == @site.domain
              # render :layout => layout
            elsif @gallery.user == current_user
              # render :layout => layout
            elsif !@gallery.city.blank?
              @city = @gallery.city
              @galleryname = @gallery.galleryname
              # render :layout => layout
          
            else
              # render
              
            end
            
            render :layout => layout
        
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

    n = Newsitem.new {}
    n.gallery = @gallery
    n.descr = 'created new gallery on'
    n.username = @current_user.username

    # only for the city
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
    
  end
  
end


