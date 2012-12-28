
class GalleriesController < ApplicationController
  
  load_and_authorize_resource
  
  def index
    @galleries = Gallery.all.fresh.order_by( :created_at => :desc )

    if params[:cityname]
      city = City.where( :cityname => params[:cityname] ).first
      @galleries = @galleries.where( 'city' => city )
    end

    if params[:my]
      @galleries = @galleries.where( :user => current_user )
    else
      @galleries = @galleries.public
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
        @galleries.each do |r|
          if r.photos[0]
            r[:photo_url] = r.photos[0].photo.url(:thumb)
          else
            r[:photo_url] = ''
          end
          r[:username] = r.user.username
          @g.push r
        end
        render :json => @g
      end
    end
  end

  def show
    if params[:galleryname].blank?
      @gallery = Gallery.find params[:id]
    else
      @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    end

    if @gallery.blank?
      flash[:error] = 'Gallery not found'
      redirect_to :action => :index

    else
      respond_to do |format|
        format.html do
        
          if !@gallery.tag.blank? && @gallery.tag.domain == @site.domain
            render :layout => 'blog'
          elsif @gallery.user == current_user
            render :action => 'my_show'
          elsif !@gallery.city.blank?
            @city = @gallery.city
            @galleryname = @gallery.galleryname
            render :layout => 'cities'
          
          else
            render
          end
        
        end
        format.json do
          photos = []
          @gallery.photos.each do |ph|
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

  def new
    @gallery = Gallery.new

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
        puts! city.errors
        flash[:error] = 'City could not be saved (newsitem).'
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
    @cities = City.list
  end

  def update
    @g = Gallery.find params[:id]
    if @g.update_attributes params[:gallery]
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to galleries_path
  end
  
  def search
    @galleries = Gallery.fresh.where( :user => current_user, :name => /#{params[:search_keyword]}/i ).page( params[:galleries_page] )
    
    render :action => :index, :layout => 'organizer'
  end
  
end


