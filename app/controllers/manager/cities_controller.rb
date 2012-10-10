

class Manager::CitiesController < ManagerController
  
  def index
    @cities = City.all
    @city = City.new
  end
  
end