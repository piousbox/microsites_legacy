

module CitiesHelper
  
  def travel_to_path city_name
    "/cities/travel-to/#{city_name}"
  end
  
  def city_path city
    "/cities/travel-to/#{city.cityname}"
  end
  
end