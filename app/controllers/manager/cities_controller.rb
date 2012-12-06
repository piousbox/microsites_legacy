

class Manager::CitiesController < ManagerController
  
  def index
    @cities = City.all
    @city = City.new
  end
  
  def show
    @city = City.find( params[:id] )
    
  end
  
  def new
    @city = City.find( params[:id] )
  end

  def create
    ;
  end

  def edit
    @city = City.find( params[:id] )
  end
  
  def update
    @city = City.find( params[:id] )
    @city.update_attributes params[:city]
    if @city.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_cities_path
  end

  def change_profile_pic
    ;
  end
  
end