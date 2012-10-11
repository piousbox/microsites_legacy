

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
  
end