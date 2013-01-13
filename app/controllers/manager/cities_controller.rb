
class Manager::CitiesController < Manager::ManagerController
  
  def index
    @cities = City.all
    @city = City.new
  end
  
  def show
    @city = City.find( params[:id] )
    
  end
  
  def new
    @city = City.new
  end

  def create
    @city = City.new params[:city]
    
    if @city.save
      flash[:notice] = 'Success'
      redirect_to manager_cities_path
    else
      flash[:error] = 'No Luck'
      render :action => :new
    end
  end

  def edit
    @city = City.find( params[:id] ) # id, not city_id, not cityname
    @newsitems = @city.newsitems.all.page( params[:newsitems_page] )
    @features = @city.features.all.page( params[:features_page] )
  end
  
  def update
    @city = City.find( params[:city_id] )
    unless params[:city][:profile_photo].blank?
      photo = Photo.new
      photo.photo = params[:city][:profile_photo]
      params[:city][:profile_photo] = nil
    end
    @city.update_attributes params[:city]
    @city.profile_photo = photo unless photo.blank?
    if @city.save
      flash[:notice] = 'Success'
      redirect_to manager_cities_path

    else
      flash[:error] = 'No Luck'
      puts! @city.errors
      render :action => :edit

    end
  end

  def change_profile_pic
    @city = City.find params[:city_id]
    @photo = Photo.new

    if params[:city_id]
      @photo = Photo.new params[:photo]
      flag = @photo.save
      @city.profile_photo = @photo
      flagg = @city.save
      if flag && flagg
        flash[:notice] = 'Success'
      else
        flash[:error] = 'No Luck'
      end

      redirect_to manager_cities_path
    end
  end

  def new_feature
    @city = City.find params[:city_id]

    @feature = Feature.new
    
  end

  def create_feature
    @city = City.find params[:city_id]
    @feature = Feature.new params[:feature]

    @city.features << @feature

    if @city.save
      flash[:notice] = 'Success.'
      redirect_to :action => :edit, :id => @city.id

    else
      flash[:error] = 'No Luck. ' + @city.errors.inspect
      puts! @city.errors
      render :action => :new_feature

    end

  end

  def edit_feature
    @city = City.find params[:city_id]
    @feature = @city.features.find params[:feature_id]

  end

  def update_feature
    @city = City.find params[:city_id]
    @feature = @city.features.find params[:feature_id]
    if @feature.update_attributes params[:feature]
      flash[:notice] = 'Success'
      redirect_to manager_cities_path
    else
      flash[:error] = 'No Luck. ' + @feature.errors.inspect
      puts! @feature.errors
      render :action => :edit_feature
    end
  end

  def new_newsitem
    @newsitem = Newsitem.new
    @city = City.find params[:city_id]

    fffind

  end

  def create_newsitem
    @city = City.find params[:city_id]

    unless params[:newsitem][:report_id].blank?
      n = Newsitem.new params[:newsitem]
      n.report = Report.find params[:newsitem][:report_id]
      n.username = params[:newsitem][:username]
      n.descr = params[:newsitem][:descr]
      @city.newsitems << n
    end

    unless params[:newsitem][:gallery_id].blank?
      n = Newsitem.new params[:newsitem]
      n.gallery = Gallery.find params[:newsitem][:gallery_id]
      n.username = params[:newsitem][:username]
      n.descr = params[:newsitem][:descr]
      @city.newsitems << n
    end

    fffind

    if @city.save
      flash[:notice] = 'Success'
      redirect_to edit_manager_city_path( @city.id )
    else
      flash[:error] = 'No Luck. ' + @city.errors.inspect
      render :action => :new_newsitem

    end

  end

  private

  def fffind
    @list_reports = Report.all.fresh.public.list
    @list_galleries = Gallery.all.fresh.public.list
    @list_users = [['', nil]] + User.all.order_by( :name => :asc ).map { |u| [u.username, u.username] }
  end

end