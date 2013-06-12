
class Manager::PhotosController < Manager::ManagerController

  before_filter :set_lists, :only => [ :new, :edit, :update ]
  
  def destroy
    @photo = Photo.find params[:id]
    old_galleryname = @photo.gallery.blank? ? 'temp-gallery' : @photo.gallery.galleryname
    
    @photo.is_trash = true

    if @photo.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end

    redirect_to manager_gallery_path(old_galleryname)
  end

  def index
    @photos = Photo.all.order_by( :created_at => :desc ).page( params[:photos_page] )
    @galleries = Gallery.list
  end

  def new
    @photo = Photo.new
  end
  
  def no_gallery
    @photos = Photo.where( :gallery => nil, :report => nil, :city => nil, :profile_user => nil )
    render 'index'
    
  end

  def edit
    @photo = Photo.find params[:id]
  end

  def update
    @photo = Photo.find(params[:id])
    path = manager_photos_path
    
    unless params[:photo][:report_id].blank?
      r = Report.find params[:photo][:report_id]
      r.photo = @photo
      r.save
    end

    unless params[:photo][:tag_id].blank?
      t = Tag.find params[:photo][:tag_id]
      t.photo = @photo
      t.save
    end

    unless params[:photo][:venue_id].blank?
      v = Venue.find params[:photo][:venue_id]
      v.profile_photo = @photo
      v.save
    end

    unless params[:photo][:gallery_id].blank?
      old_galleryname = @photo.gallery.blank? ? 'temp-gallery' : @photo.gallery.galleryname
      path = manager_gallery_path(old_galleryname)
    end
    
    flag = @photo.update_attributes params[:photo]

    respond_to do |format|
      format.html do
        if flag
          flash[:notice] = 'Success'
          redirect_to path
        else
          flash[:error] = 'No Luck.'
          render :edit
        end
      end
      format.json do
        if flag
          render :json => []
        else
          render :json => @photo.errors, :status => :unprocessable_entry
        end
      end
    end
  end

  private

  def set_lists
    @galleries = Gallery.list
    @reports = Report.list
    @friends = User.list
    @tags = Tag.list
    @list_venues = Venue.list
    @list_users = User.list
    @cities = City.list
  end
  
end
