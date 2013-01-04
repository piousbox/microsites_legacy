
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
    @city = City.find( params[:id] )
  end
  
  def update
    @city = City.find( params[:id] )
    unless params[:city][:profile_photo].blank?
      photo = Photo.new
      photo.photo = params[:city][:profile_photo]
      params[:city][:profile_photo] = nil
    end
    @city.update_attributes params[:city]
    @city.profile_photo = photo unless photo.blank?
    if @city.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_cities_path
  end

  def change_profile_pic
    @city = City.find params[:id]
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
  
end