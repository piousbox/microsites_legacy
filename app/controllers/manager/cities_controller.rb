
class Manager::CitiesController < Manager::ManagerController

  before_filter :set_lists, :only => [ :new_newsitem, :create_newsitem ]
  before_filter :set_city, :only => [ :show, :edit ]

  def index
    @cities = City.all
    @city = City.new
  end
  
  def show
    ;
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
    @city = City.find params[:id]
    @photo = Photo.new
  end
  
  def update
    @city = City.find( params[:id] )
    @city.update_attributes params[:city]
    
    if @city.save
      flash[:notice] = 'Success'
      redirect_to manager_cities_path

    else
      flash[:error] = 'No Luck. ' + @city.errors.inspect
      @newsitems = @city.newsitems.all.page( params[:newsitems_page] )
      @features = @city.features.all.page( params[:features_page] )
      render :action => :edit

    end
    
  end

  def change_profile_pic
    @city = City.find params[:id]
    
    @photo = Photo.new params[:photo]
    @photo.user = @current_user
    flag = @photo.save
    @city.profile_photo = @photo
    flagg = @city.save
    if flag && flagg
      flash[:notice] = 'Success'
    else
      flash[:error] = "No Luck. #{@photo.errors.inspect} #{@city.errors.inspect}"
      puts! @photo.errors.inspect
      puts! @city.errors.inspect
    end

    redirect_to manager_cities_path
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
      render :action => :edit_feature
    end
  end

  def new_newsitem
    @newsitem = Newsitem.new
    @city = City.find params[:city_id]

  end

  def create_newsitem

    n = Newsitem.new params[:newsitem]
    n.report = Report.find params[:newsitem][:report_id] unless params[:newsitem][:report_id].blank?
    n.gallery = Gallery.find params[:newsitem][:gallery_id] unless params[:newsitem][:gallery_id].blank?
    n.photo = Photo.find params[:newsitem][:photo_id] unless params[:newsitem][:photo_id].blank?
    n.descr = params[:newsitem][:descr]

    @city = City.find params[:city_id]
    @city.newsitems << n

    if @city.save
      flash[:notice] = 'Success'
      redirect_to edit_manager_city_path( @city.id )
    else
      flash[:error] = 'No Luck. ' + @city.errors.inspect
      render :action => :new_newsitem

    end

  end

  private

  def set_city
    @city = City.find( params[:id] )
    @newsitems = @city.newsitems.order_by( :created_at => :desc ).page( params[:newsitems_page] )
    @features = @city.features.all.page( params[:features_page] )
  end

  def set_lists
    @list_reports = Report.all.list
    @list_galleries = Gallery.all.list
    @list_users = [['', nil]] + User.all.order_by( :name => :asc ).map { |u| [u.username, u.username] }
  end

end