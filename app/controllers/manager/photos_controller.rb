
class Manager::PhotosController < Manager::ManagerController
  
  def destroy
    @photo = Photo.find params[:id]
    
    unless @photo.gallery.blank?
      galleryname = @photo.gallery.galleryname
      gid = @photo.gallery.id
    end

    @photo.is_trash = true

    if @photo.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    
    if galleryname.blank?
      redirect_to manager_photos_no_gallery_path
    else
      redirect_to manager_gallery_path(gid)
    end
    
  end

  def index
    @photos = Photo.all.fresh.order_by( :created_at => :desc )
    @galleries = Gallery.list
  end

  def new
    @reports = Report.list
    @photo = Photo.new
  end
  
  def move
    @photo = Photo.find params[:id]
    
    old_galleryname = @photo.gallery.galleryname
    
    g = Gallery.find(params[:photo][:gallery_id])
    @photo.gallery = g
    
    if @photo.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    
    redirect_to manager_gallery_path(old_galleryname)
  end
  
  def no_gallery
    @photos = Photo.where( :gallery => nil, :report => nil, :city => nil, :profile_user => nil )
    render 'index'
    
  end

  def edit
    @galleries = Gallery.list
    @reports = Report.list
    @photo = Photo.find params[:id]
  end

  def update
    ;
  end
  
end