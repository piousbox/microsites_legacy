

class GalleriesController < ApplicationController
  
  load_and_authorize_resource
  
  def index
    if params[:cityname].blank?
      @galleries = Gallery.all.fresh.public.page( params[:galleries_page] )
    else
      city = City.where( :cityname => params[:cityname] ).first
      @galleries = Gallery.all.fresh.public.where( 'city' => city ).page( params[:galleries_page] )
    end

    respond_to do |format|
      format.html do
        render :layout => false
      end
      format.json do
        @g = []
        @galleries.each do |r|
          r[:photo_url] = r.photos[0].photo.url(:thumb)
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
      @gallery = Gallery.where( :galleryname => params[:galleryname]).first
    end

    respond_to do |format|
      format.html
      format.json do
        photos = []
        @gallery.photos.each do |ph|
          p = ph.photo.url(:thumb)
          photos.push p
        end
        @gallery[:photo_urls] = photos
        render :json => @gallery
      end
    end
  end

  def new
    @gallery = Gallery.new

    respond_to do |format|
      format.html 
      format.json { render :json => @gallery }
    end
  end

  def create
    
    @gallery = Gallery.new(params[:gallery])
    
    @gallery[:user_id] = current_user[:id]
    @gallery[:name_seo] = @gallery[:name]

    begin
      @gallery.save
      redirect_to :controller => 'photos', :action => 'driver', :gallery_id => @gallery.id
      # render 'photos/driver'
    rescue ActiveRecord::RecordInvalid 
      flash[:error] = @gallery.errors
      respond_to do |format|
        format.html { render :action => "new" }
        format.json { render :json => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  def search
    @galleries = Gallery.paginate :page => params[:galleries_page],
      :conditions => { :is_public => 1, :is_trash => 0 }
    
    render :action => :index
  end
  
end
