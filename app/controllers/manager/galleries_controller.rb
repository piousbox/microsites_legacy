
class Manager::GalleriesController < Manager::ManagerController
  
  def destroy
    @g = Gallery.where( :galleryname =>  params[:galleryname] ).first
    @g.is_trash = 1
    
    if @g.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    
    redirect_to manager_galleries_path
  end

  def create
    @gallery = Gallery.new params[:gallery]
    @gallery.user = current_user
    
    if @gallery.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_galleries_path
  end

  def edit
    if params[:galleryname].blank?
      @gallery = Gallery.find params[:id]
    else
      @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    end
    
    @cities = City.list
    @venues_list = Venue.all.list
    @sites_list = Site.all.list
  end

  def update
    if params[:galleryname]
      @g = Gallery.where( :galleryname => params[:galleryname] ).first
    else
      @g = Gallery.find params[:id]
    end

    flag = @g.update_attributes params[:gallery]
    
    respond_to do |format|
      format.html do
        if flag
          flash[:notice] = 'Success'
          redirect_to manager_galleries_path
        else
          flash[:error] = 'No Luck'
          render :action => :edit
        end
      end
      format.json do
        # head :ok
        render :json => []
      end
    end
  end
  
  def index
    @galleries = Gallery.all.order_by( :created_at => :desc )
    @galleries = @galleries.where( :is_public => true ) if '1' == params[:public]
    @galleries = @galleries.where( :is_public => false ) if '0' == params[:public]
    @galleries = @galleries.where( :is_done => true ) if '1' == params[:done]
    @galleries = Gallery.where( :is_trash => true ) if '1' == params[:is_trash]
    @galleries = @galleries.where( :name => /#{params[:keywords]}/i ) if params[:keywords] && '' != params[:keywords]

    respond_to do |format|
      format.html do

        unless params[:fullindex]
          @galleries = @galleries.page( params[:galleries_page] ).per( Gallery.n_per_manager_page )
        end

        if params[:short_list]
          render 'index_short'
        else
          render
        end
      end
      format.json do
        @galleries = @galleries.to_a
        @galleries.map do |g|
          g[:n_photos] = g.photos.length
          g[:thumb_urls] = g.photos.map { |r| r.photo.url(:mini) }
        end
        render :json => @galleries
      end
    end
  end

  def all_photos
    @photos = Photo.all
    
  end
  
  def show
    @galleries = Gallery.list

    @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    @gallery ||= Gallery.where( :galleryname => params[:id] ).first

    respond_to do |format|
      format.html
      format.json do
        @gallery[:n_photos] = @gallery.photos.length
        render :json => @gallery
      end
    end
  end
  
  def new
    @gallery = Gallery.new
    @cities = City.list
    @venues_list = Venue.all.list
  end
  
end
