
class Manager::GalleriesController < Manager::ManagerController
  
  def destroy
    @g = Gallery.find params[:id]
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
    @gallery = Gallery.find( params[:id] )
    @cities = City.list
  end

  def update
    @g = Gallery.find params[:id]
    if @g.update_attributes params[:gallery]
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_galleries_path
  end
  
  def index
    @galleries = Gallery.fresh
    
    if '1' == params[:public]
      @galleries = @galleries.public
    end
    
    if '1' == params[:done]
      @galleries = @galleries.done
    end

    if params[:keywords] && '' != params[:keywords]
      @galleries = @galleries.where( :name => /#{params[:keywords]}/i )
    end
    
    @galleries = @galleries.page( params[:galleries_page] ).order_by( :created_at => :desc ).per(10)

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