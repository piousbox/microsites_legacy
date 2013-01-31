
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
  end

  def update
    if params[:galleryname]
      @g = Gallery.where( :galleryname => params[:galleryname] ).first
    else
      @g = Gallery.find params[:id]
    end
    
    if @g.update_attributes params[:gallery]
      flash[:notice] = 'Success'
      redirect_to manager_galleries_path
    else
      flash[:error] = 'No Luck'
      render :action => :edit
    end
    
  end
  
  def index
    @galleries = Gallery.all
    
    if '1' == params[:public]
      @galleries = @galleries.public
    end
    
    if '1' == params[:done]
      @galleries = @galleries.done
    end

    if params[:keywords] && '' != params[:keywords]
      @galleries = @galleries.where( :name => /#{params[:keywords]}/i )
    end
    
    @galleries = @galleries.page( params[:galleries_page] ).order_by( :created_at => :desc ).per( Gallery.n_per_manager_page )

    if params[:short_list]
      render 'index_short'
    else
      render
    end
  end
  
  def all_photos
    @photos = Photo.all
    
  end
  
  def show
    @galleries = Gallery.list

    @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    if @gallery.blank?
      flash[:notice] = 'New Gallery'
      @gallery = Gallery.new
    end
    
  end
  
  def new
    @gallery = Gallery.new
    @cities = City.list
  end
  
end